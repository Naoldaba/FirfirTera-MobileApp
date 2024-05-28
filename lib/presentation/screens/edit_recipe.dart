import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firfir_tera/models/Recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/providers/recipe_provider.dart';
import 'package:firfir_tera/presentation/services/recipe_services.dart';

class EditRecipeScreen extends ConsumerStatefulWidget {
  final Recipe recipe;

  const EditRecipeScreen({required this.recipe, Key? key}) : super(key: key);

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends ConsumerState<EditRecipeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final List<TextEditingController> _ingredientControllers = [];
  final List<TextEditingController> _stepControllers = [];

  File? _image;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.recipe.name;
    _descriptionController.text = widget.recipe.description;
    _cookTimeController.text = widget.recipe.cookTime.toString();
    _peopleController.text = widget.recipe.people.toString();
    _typeController.text = widget.recipe.type;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(recipeNotifierProvider.notifier).setRecipe(widget.recipe);
    });

    for (var ingredient in widget.recipe.ingredients) {
      _ingredientControllers.add(TextEditingController(text: ingredient));
    }

    for (var step in widget.recipe.steps) {
      _stepControllers.add(TextEditingController(text: step));
    }
  }


  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _cookTimeController.dispose();
    _peopleController.dispose();
    _typeController.dispose();
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    for (var controller in _stepControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipe = ref.watch(recipeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Recipe'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                ref
                    .read(recipeNotifierProvider.notifier)
                    .updateRecipe(name: value);
              },
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                ref
                    .read(recipeNotifierProvider.notifier)
                    .updateRecipe(description: value);
              },
            ),
            TextField(
              controller: _cookTimeController,
              decoration: InputDecoration(labelText: 'Cook Time'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                ref
                    .read(recipeNotifierProvider.notifier)
                    .updateRecipe(cookTime: int.parse(value));
              },
            ),
            TextField(
              controller: _peopleController,
              decoration: InputDecoration(labelText: 'People'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                ref
                    .read(recipeNotifierProvider.notifier)
                    .updateRecipe(people: int.parse(value));
              },
            ),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Type'),
              onChanged: (value) {
                ref
                    .read(recipeNotifierProvider.notifier)
                    .updateRecipe(type: value);
              },
            ),
            SizedBox(height: 16),
            Text('Ingredients'),
            Column(
              children: List.generate(_ingredientControllers.length, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ingredientControllers[index],
                        decoration: InputDecoration(
                          labelText: 'Ingredient ${index + 1}',
                        ),
                        onChanged: (value) {
                          final ingredients = _ingredientControllers
                              .map((controller) => controller.text)
                              .toList();
                          ref
                              .read(recipeNotifierProvider.notifier)
                              .updateRecipe(ingredients: ingredients);
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _ingredientControllers.removeAt(index);
                          final ingredients = _ingredientControllers
                              .map((controller) => controller.text)
                              .toList();
                          ref
                              .read(recipeNotifierProvider.notifier)
                              .updateRecipe(ingredients: ingredients);
                        });
                      },
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _ingredientControllers.add(TextEditingController());
                });
              },
              child: Text('Add Ingredient'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
            ),
            SizedBox(height: 16),
            Text('Steps'),
            Column(
              children: List.generate(_stepControllers.length, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _stepControllers[index],
                        decoration: InputDecoration(
                          labelText: 'Step ${index + 1}',
                        ),
                        onChanged: (value) {
                          final steps = _stepControllers
                              .map((controller) => controller.text)
                              .toList();
                          ref
                              .read(recipeNotifierProvider.notifier)
                              .updateRecipe(steps: steps);
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _stepControllers.removeAt(index);
                          final steps = _stepControllers
                              .map((controller) => controller.text)
                              .toList();
                          ref
                              .read(recipeNotifierProvider.notifier)
                              .updateRecipe(steps: steps);
                        });
                      },
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _stepControllers.add(TextEditingController());
                });
              },
              child: Text('Add Step'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_image != null) {
                  await sendPatchRequest(
                    context: context,
                    name: _nameController.text,
                    description: _descriptionController.text,
                    cookTime: _cookTimeController.text,
                    people: _peopleController.text,
                    type: _typeController.text,
                    image: _image!,
                    ingredients: _ingredientControllers.map((controller) => controller.text).toList(),
                    steps: _stepControllers.map((controller) => controller.text).toList(),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select an image')),
                  );
                }
              },
              child: Text('Save Changes'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
            ),
          ],
        ),
      ),
    );
  }
}
