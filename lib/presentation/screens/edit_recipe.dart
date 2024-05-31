import 'dart:io';
import 'package:firfir_tera/presentation/services/recipe_services.dart';
import 'package:firfir_tera/providers/create_recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/models/Recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/providers/recipe_provider.dart';
import 'package:image_picker/image_picker.dart';

class EditRecipeScreen extends ConsumerStatefulWidget {
  final Recipe recipe;

  const EditRecipeScreen({required this.recipe, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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


  final _tempImage = ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Image.asset(
      'assets/images/kikil.jpg',
      fit: BoxFit.cover,
    ),
  );

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
  Widget bottomSheet(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Choose Image',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  ref.read(imageNotifierProvider.notifier).pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () {
                  ref.read(imageNotifierProvider.notifier).pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FoodType foodType = FoodType.fasting;
    final foodTypeProv = ref.read(foodTypeProvider.notifier);
    final ingredients = ref.watch(ingredientsNotifierProvider);
    final steps = ref.watch(stepNotifierProvider);
    final image = ref.watch(imageNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Recipe'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: image == null
                        ? _tempImage
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.file(File(image.path), fit: BoxFit.cover),
                          ),
                  ),
                  Positioned(
                    top: 10,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (builder) => bottomSheet(context, ref),
                        );
                      },
                    ),
                  ),
                ],
              ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                ref
                    .read(recipeNotifierProvider.notifier)
                    .updateRecipe(name: value);
              },
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                ref
                    .read(recipeNotifierProvider.notifier)
                    .updateRecipe(description: value);
              },
            ),
            TextField(
              controller: _cookTimeController,
              decoration: const InputDecoration(labelText: 'Cook Time'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                ref
                    .read(recipeNotifierProvider.notifier)
                    .updateRecipe(cookTime: int.tryParse(value));
              },
            ),
            TextField(
              controller: _peopleController,
              decoration: const InputDecoration(labelText: 'People'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                ref
                    .read(recipeNotifierProvider.notifier)
                    .updateRecipe(people:int.tryParse(value));
              },
            ),
            DropdownButtonFormField<FoodType>(
                value: foodType,
                onChanged: (newValue) {
                  foodTypeProv.setState(newValue as FoodType);
                },
                items: FoodType.values.map((FoodType type) {
                  return DropdownMenuItem<FoodType>(
                    value: type,
                    child: Text(
                      type == FoodType.fasting ? 'fasting' : 'non-fasting',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Food Type",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
            ),
            const SizedBox(height: 16),
            const Text('Ingredients'),
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
                      icon: const Icon(Icons.delete),
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _ingredientControllers.add(TextEditingController());
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
              child: const Text('Add Ingredient'),
            ),
            const SizedBox(height: 16),
            const Text('Steps'),
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
                      icon: const Icon(Icons.delete),
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _stepControllers.add(TextEditingController());
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
              child: const Text('Add Step'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                  
                  if (_nameController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty &&
                      _cookTimeController.text.isNotEmpty &&
                      _peopleController.text.isNotEmpty &&
                      image != null &&
                      _ingredientControllers.isNotEmpty &&
                      _stepControllers.isNotEmpty) {
                    
                    await sendPostRequest(
                      context: context,
                      name: _nameController.text,
                      description: _descriptionController.text,
                      cookTime: _cookTimeController.text,
                      people: _peopleController.text,
                      type: foodType.toString(), 
                      image: File(image.path),
                      ingredients: ingredients.map((ingredient) => ingredient.nameController.text).toList(),
                      steps: steps.map((step) => step.stepController.text).toList(),
                    );
                  } else {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all required fields'),
                      ),
                    );
                  }
                },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
