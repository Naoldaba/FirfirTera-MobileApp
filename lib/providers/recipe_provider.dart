import 'dart:convert';
import 'package:firfir_tera/presentation/screens/create_recipe_page.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firfir_tera/models/Recipe.dart';

part 'recipe_provider.g.dart';

@riverpod
Future<List<Recipe>> recipes(RecipesRef ref) async {
  final response = await http.get(Uri.parse(""));
  // return [
  //   Recipe(
  //     id:'1',
  //     image: 'assets/images/kikil.jpg',
  //     name: 'Kikil',
  //     description: '',
  //     cookTime: 10,
  //     people: 50,
  //     ingredients: ["light", 'souce'],
  //     steps: ['dark', 'moist'],
  //     fasting: false,
  //     type: 'fasting',
  //   ),
  //   Recipe(
  //     id:'2',
  //     image: 'assets/images/tibs.jpg',
  //     name: 'Tibs',
  //     description: '',
  //     cookTime: 0,
  //     people: 0,
  //     ingredients: [],
  //     steps: [],
  //     fasting: false,
  //     type: '',
  //   ),
  // ];
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((recipe) => Recipe.fromJson(recipe)).toList();

  } else {
    throw Exception("");
  }
}

enum FoodType { fasting, nonfasting }

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
Future<List<Recipe>> breakfastRecipes(BreakfastRecipesRef ref) async {
  final response = await http.get(Uri.parse(""));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data
        .map((recipe) => Recipe.fromJson(recipe))
        .where((recipe) => recipe.type == 'breakfast')
        .toList();
  } else {
    throw Exception("");
    ;
  }
}

@riverpod
Future<List<Recipe>> lunchRecipes(LunchRecipesRef ref) async {
  final response = await http.get(Uri.parse(""));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data
        .map((recipe) => Recipe.fromJson(recipe))
        .where((recipe) => recipe.type == 'lunch')
        .toList();
  } else {
    throw Exception("");
  }
}

@riverpod
Future<List<Recipe>> dinnerRecipes(DinnerRecipesRef ref) async {
  final response = await http.get(Uri.parse(""));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data
        .map((recipe) => Recipe.fromJson(recipe))
        .where((recipe) => recipe.type == 'dinner')
        .toList();
  } else {
    throw Exception("");
  }
}

@riverpod
class RecipeNotifier extends _$RecipeNotifier {
  @override
  Recipe build() {
    return Recipe(
      id:'1',
      name: '',
      description: '',
      cookTime: 0,
      people: 0,
      ingredients: [],
      steps: [],
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
