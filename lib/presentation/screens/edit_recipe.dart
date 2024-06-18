import 'dart:io';
import 'package:firfir_tera/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/models/Recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/providers/recipe_provider.dart';
import 'package:firfir_tera/providers/edit_recipe_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.recipe.name;
    _descriptionController.text = widget.recipe.description;
    _cookTimeController.text = widget.recipe.cookTime.toString();
    _peopleController.text = widget.recipe.people.toString();
    _typeController.text = widget.recipe.type;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(ingredientsEditNotifierProvider.notifier)
          .setInitialIngredients(widget.recipe.ingredients);
      ref
          .read(stepsEditNotifierProvider.notifier)
          .setInitialSteps(widget.recipe.steps);
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
    ref
        .read(ingredientsEditNotifierProvider.notifier)
        .state
        .forEach((controller) => controller.dispose());
    ref
        .read(stepsEditNotifierProvider.notifier)
        .state
        .forEach((controller) => controller.dispose());
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
                  ref
                      .read(imageNotifierProvider.notifier)
                      .pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () {
                  ref
                      .read(imageNotifierProvider.notifier)
                      .pickImage(ImageSource.gallery);
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
    final selectedFoodType = ref.watch(selectedFoodTypeProvider);
    final fastingBoolean = selectedFoodType == FoodType.fasting;
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final service = ref.watch(recipeServiceProvider);
    final ingredients = ref.watch(ingredientsEditNotifierProvider);
    final steps = ref.watch(stepsEditNotifierProvider);
    final image = ref.watch(imageNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Recipe'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          widget.recipe.image,
                          fit: BoxFit.cover,
                        ),
                      )
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
                  .watch(recipeNotifierProvider.notifier)
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
                  .updateRecipe(people: int.tryParse(value));
            },
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<FoodType>(
            value: selectedFoodType,
            onChanged: (newValue) {
              if (newValue != null) {
                ref.read(selectedFoodTypeProvider.notifier).state = newValue;
                ref.read(foodTypeBooleanProvider.notifier).state =
                    newValue == FoodType.fasting;
              }
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
          const SizedBox(height: 20),
          DropdownButtonFormField<FoodCategory>(
            value: selectedCategory,
            onChanged: (newValue) {
              if (newValue != null) {
                ref.read(selectedCategoryProvider.notifier).state = newValue;
              }
            },
            items: FoodCategory.values.map((FoodCategory category) {
              return DropdownMenuItem<FoodCategory>(
                value: category,
                child: Text(
                  category.toString().split('.')[1].toUpperCase(),
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: "Category",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          const Text('Ingredients'),
          Column(
            children: List.generate(ingredients.length, (index) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: ingredients[index],
                      decoration: InputDecoration(
                        labelText: 'Ingredient ${index + 1}',
                      ),
                      onChanged: (value) {
                        ref
                            .read(ingredientsEditNotifierProvider.notifier)
                            .updateIngredientController(index, value);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(ingredientsEditNotifierProvider.notifier)
                          .removeIngredientController(index);
                    },
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(ingredientsEditNotifierProvider.notifier)
                  .addIngredientController(TextEditingController());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
            ),
            child: const Text('Add Ingredient'),
          ),
          const SizedBox(height: 16),
          const Text('Steps'),
          Column(
            children: List.generate(steps.length, (index) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: steps[index],
                      decoration: InputDecoration(
                        labelText: 'Step ${index + 1}',
                      ),
                      onChanged: (value) {
                        ref
                            .read(stepsEditNotifierProvider.notifier)
                            .updateStepController(index, value);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(stepsEditNotifierProvider.notifier)
                          .removeStepController(index);
                    },
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(stepsEditNotifierProvider.notifier)
                  .addStepController(TextEditingController());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
            ),
            child: const Text('Add Step'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async{
              print('Name: ${_nameController.text}');
              print('Description: ${_descriptionController.text}');
              print('Cook Time: ${_cookTimeController.text}');
              print('People: ${_peopleController.text}');
              print('Image: ${image?.path}');
              print('Ingredients: ${ingredients.map((controller) => controller.text).toList()}');
              print('Steps: ${steps.map((controller) => controller.text).toList()}');
              if (_nameController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty &&
                  _cookTimeController.text.isNotEmpty &&
                  _peopleController.text.isNotEmpty &&
                  ingredients.isNotEmpty &&
                  image != null &&
                  steps.isNotEmpty) {
                bool isSuccess = await service.sendPatchRequest(
                  context: context,
                  id: widget.recipe.id,
                  name: _nameController.text,
                  description: _descriptionController.text,
                  cookTime: _cookTimeController.text,
                  people: _peopleController.text,
                  type: selectedCategory.toString(),
                  fasting: fastingBoolean,
                  image: File(image.path),
                  ingredients:
                      ingredients.map((controller) => controller.text).toList(),
                  steps: steps.map((controller) => controller.text).toList(),
                );

                if (isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('successfully updated recipe')));
                  refreshNotifier.refresh();
                  ref.read(selectedIndexProvider.notifier).state = 0;
                  context.go('/home');

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Unable to update the recipe')));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all required fields'),
                  ),
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
            ),
            child: const Text('Save Changes'),
          ),
        ]),
      ),
    );
  }
}