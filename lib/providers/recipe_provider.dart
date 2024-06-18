import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firfir_tera/models/Recipe.dart';
import 'package:firfir_tera/presentation/services/recipe_services.dart';

part 'recipe_provider.g.dart';

enum FoodType { fasting, nonfasting }

enum FoodCategory { breakfast, lunch, dinner }

final recipeServiceProvider = Provider((ref) => RecipeServices());

final recipesProvider = FutureProvider.autoDispose<List<Recipe>>((ref) async {
  final service = ref.watch(recipeServiceProvider);
  return service.recipes();
});

final breakfastRecipesProvider = FutureProvider.autoDispose<List<Recipe>>((ref) async {
  final service = ref.watch(recipeServiceProvider);
  return service.breakfastRecipes();
});

final lunchRecipesProvider = FutureProvider.autoDispose<List<Recipe>>((ref) async {
  final service = ref.watch(recipeServiceProvider);
  return service.lunchRecipes();
});

final dinnerRecipesProvider = FutureProvider.autoDispose<List<Recipe>>((ref) async {
  final service = ref.watch(recipeServiceProvider);
  return service.dinnerRecipes();
});

final deleteRecipeProvider =
    FutureProvider.family<bool, String>((ref, id) async {
  final service = ref.watch(recipeServiceProvider);
  return service.DeleteRecipe(id);
});

final patchRecipeProvider =
    FutureProvider.family<void, PatchRecipeParams>((ref, params) async {
  final service = ref.watch(recipeServiceProvider);
  await service.sendPatchRequest(
    context: params.context,
    id: params.id,
    name: params.name,
    description: params.description,
    cookTime: params.cookTime,
    people: params.people,
    type: params.type,
    fasting: params.fasting,
    image: params.image,
    ingredients: params.ingredients,
    steps: params.steps,
  );
});

final postRecipeProvider =
    FutureProvider.family<void, PostRecipeParams>((ref, params) async {
  final service = ref.watch(recipeServiceProvider);
  await service.sendPostRequest(
    context: params.context,
    name: params.name,
    description: params.description,
    cookTime: params.cookTime,
    people: params.people,
    fasting: params.fasting,
    type: params.type,
    image: params.image,
    ingredients: params.ingredients,
    steps: params.steps,
  );
});

@riverpod
class foodType extends _$foodType {
  @override
  FoodType build() {
    return FoodType.fasting;
  }

  void setState(FoodType newValue) {
    state = newValue;
  }
}

@riverpod
class RecipeNotifier extends _$RecipeNotifier {
  @override
  Recipe build() {
    return Recipe(
      id: '1',
      name: '',
      description: '',
      cookTime: 0,
      people: 0,
      ingredients: ['afds'],
      steps: ['asdfasd'],
      fasting: false,
      type: '',
      image: '',
    );
  }

  void setRecipe(Recipe recipe) {
    state = recipe;
  }

  void updateRecipe({
    String? name,
    String? description,
    int? cookTime,
    int? people,
    List<String>? ingredients,
    List<String>? steps,
    bool? fasting,
    String? type,
  }) {
    state = state.copyWith(
      name: name,
      description: description,
      cookTime: cookTime,
      people: people,
      ingredients: ingredients,
      steps: steps,
      fasting: fasting,
      type: type,
    );
  }
}

class RefreshNotifier extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}

final refreshNotifier = RefreshNotifier();

final selectedFoodTypeProvider = StateProvider<FoodType?>((ref) => null);

final foodTypeBooleanProvider = StateProvider<bool>((ref) {
  final foodType = ref.watch(selectedFoodTypeProvider);
  return foodType == FoodType.fasting;
});

final selectedCategoryProvider =
    StateProvider<FoodCategory>((ref) => FoodCategory.breakfast);
