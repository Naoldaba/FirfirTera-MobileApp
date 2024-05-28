import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_recipe_provider.g.dart';

class Ingredient {
  final TextEditingController nameController;

  Ingredient({required this.nameController});
}

class Step {
  final TextEditingController stepController;

  Step({required this.stepController});
}


@riverpod
class IngredientsNotifier extends _$IngredientsNotifier {
  @override
  List<Ingredient> build() {
    return [
      Ingredient(nameController: TextEditingController()),
      Ingredient(nameController: TextEditingController()),
      Ingredient(nameController: TextEditingController()),
      
    ];
  }

  void addIngredient() {
    state = [...state, Ingredient(nameController: TextEditingController())];
  }

  void removeIngredient(int index) {
    state[index].nameController.dispose();
    state = [...state]..removeAt(index);
  }
}

@riverpod
class StepNotifier extends _$StepNotifier {
  @override
  List<Step> build() {
    return [
      Step(stepController: TextEditingController()),
      Step(stepController: TextEditingController()),
      Step(stepController: TextEditingController()),
    ];
  }

  void addSteps() {
    state = [...state, Step(stepController: TextEditingController())];
  }

  void removeSteps(int index) {
    state[index].stepController.dispose();
    state = [...state]..removeAt(index);
  }
}

class ImageNotifier extends StateNotifier<PickedFile?> {
  ImageNotifier() : super(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      if (pickedFile != null) {
        state = pickedFile;
      } else {
        state = null;
      }
    } catch (e) {
      print("Error picking image: $e");
      state = null;
    }
  }
}

final imageNotifierProvider = StateNotifierProvider<ImageNotifier, PickedFile?>((ref) => ImageNotifier());
