import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firfir_tera/providers/create_recipe_provider.dart';
import 'package:firfir_tera/providers/ingredients_adder_providers.dart';

void main() {
  group('IngredientsNotifier', () {
    test('addIngredient adds an ingredient', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final ingredientsNotifier =
          container.read(ingredientListProvider.notifier);

      // Get the initial state of the ingredients list
      final initialIngredientsCount = ingredientsNotifier.state.length;

      // Call addIngredient
      ingredientsNotifier.addController();

      // Check if the state has one more ingredient
      expect(ingredientsNotifier.state.length, initialIngredientsCount + 2);

      // Dispose the container after use
      container.dispose();
    });
  });

  group('StepNotifier', () {
    test('addSteps adds a step', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final ingredientsNotifier =
          container.read(ingredientListProvider.notifier);

      // Get the initial state of the ingredients list
      final initialIngredientsCount = ingredientsNotifier.state.length;

      // Call addIngredient
      ingredientsNotifier.addController();

      // Check if the state has one more ingredient
      expect(ingredientsNotifier.state.length, initialIngredientsCount + 2);

      // Dispose the container after use
      container.dispose();
    });
  });
}
