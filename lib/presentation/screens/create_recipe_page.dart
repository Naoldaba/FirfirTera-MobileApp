import 'dart:io';
import 'package:firfir_tera/providers/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/providers/create_recipe_provider.dart';
import 'package:firfir_tera/presentation/services/recipe_services.dart';

class CreateRecipe extends ConsumerWidget {
  CreateRecipe({super.key});

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final _peopleController = TextEditingController();

  final _tempImage = ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Image.asset(
      'assets/images/kikil.jpg',
      fit: BoxFit.cover,
    ),
  );

  final primeryColor = Colors.orange;

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
  Widget build(BuildContext context, WidgetRef ref) {
    FoodType _foodType = FoodType.fasting;
    final _foodTypeProv = ref.read(foodTypeProvider.notifier);
    final ingredients = ref.watch(ingredientsNotifierProvider);
    final steps = ref.watch(stepNotifierProvider);
    final image = ref.watch(imageNotifierProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(height: 15),
              Text(
                'Create Recipe',
                style: GoogleFonts.firaSans(fontSize: 40),
              ),
              const SizedBox(height: 20),
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
                            child: Image.file(File(image.path), fit: BoxFit.cover),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                  ),
                  Positioned(
                    top: 10,
                    right: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: primeryColor,
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
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  prefixIcon: Icon(
                    Icons.local_dining,
                    color: primeryColor,
                  ),
                  prefixText: "Recipe Name    ",
                  prefixStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Enter Recipe Name",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primeryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _peopleController,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  prefixIcon: Icon(
                    Icons.person,
                    color: primeryColor,
                  ),
                  prefixText: "Serves    ",
                  prefixStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Enter Number of Serves",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primeryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _cookTimeController,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  prefixIcon: Icon(
                    Icons.access_time,
                    color: primeryColor,
                  ),
                  prefixText: "Cooking Time    ",
                  prefixStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Enter Cooking Time in Minutes",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primeryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<FoodType>(
                value: _foodType,
                onChanged: (newValue) {
                  _foodTypeProv.setState(newValue as FoodType);
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
              TextField(
                controller: _descriptionController,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  prefixIcon: Icon(
                    Icons.description,
                    color: primeryColor,
                  ),
                  prefixText: "Description    ",
                  prefixStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Enter description about the food",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primeryColor),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Ingredients",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: ingredients.length,
                        itemBuilder: (context, index) {
                          final ingredient = ingredients[index];
                          return Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: ingredient.nameController,
                                  decoration: InputDecoration(
                                    hintText: 'Ingredient ${index + 1}',
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: () => ref.read(ingredientsNotifierProvider.notifier).removeIngredient(index),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () => ref.read(ingredientsNotifierProvider.notifier).addIngredient(),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Add Ingredient",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Steps",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: steps.length,
                        itemBuilder: (context, index) {
                          final step = steps[index];
                          return Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: step.stepController,
                                  decoration: InputDecoration(
                                    hintText: 'Steps ${index + 1}',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: () => ref
                                    .read(ingredientsNotifierProvider.notifier)
                                    .removeIngredient(index),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () => ref
                          .read(ingredientsNotifierProvider.notifier)
                          .addIngredient(),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Add Steps",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  
                  if (_nameController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty &&
                      _cookTimeController.text.isNotEmpty &&
                      _peopleController.text.isNotEmpty &&
                      image != null &&
                      ingredients.isNotEmpty &&
                      steps.isNotEmpty) {
                    
                    await sendPostRequest(
                      context: context,
                      name: _nameController.text,
                      description: _descriptionController.text,
                      cookTime: _cookTimeController.text,
                      people: _peopleController.text,
                      type: _foodType.toString(), 
                      image: File(image.path),
                      ingredients: ingredients.map((ingredient) => ingredient.nameController.text).toList(),
                      steps: steps.map((step) => step.stepController.text).toList(),
                    );
                  } else {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill all required fields'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Save My Recipe'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
