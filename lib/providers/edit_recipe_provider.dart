import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final ingredientsEditNotifierProvider = StateNotifierProvider<IngredientsEditNotifier, List<TextEditingController>>(
  (ref) => IngredientsEditNotifier(),
);

class IngredientsEditNotifier extends StateNotifier<List<TextEditingController>> {
  IngredientsEditNotifier() : super([]);

  void setInitialIngredients(List<String> ingredients) {
    state = ingredients.map((ingredient) => TextEditingController(text: ingredient)).toList();
  }

  void addIngredientController(TextEditingController controller) {
    state = [...state, controller];
  }

  void removeIngredientController(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i]
    ];
  }

  void updateIngredientController(int index, String value) {
    state[index].text = value;
  }
}

final stepsEditNotifierProvider = StateNotifierProvider<StepsEditNotifier, List<TextEditingController>>(
  (ref) => StepsEditNotifier(),
);

class StepsEditNotifier extends StateNotifier<List<TextEditingController>> {
  StepsEditNotifier() : super([]);

  void setInitialSteps(List<String> steps) {
    state = steps.map((step) => TextEditingController(text: step)).toList();
  }

  void addStepController(TextEditingController controller) {
    state = [...state, controller];
  }

  void removeStepController(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i]
    ];
  }

  void updateStepController(int index, String value) {
    state[index].text = value;
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