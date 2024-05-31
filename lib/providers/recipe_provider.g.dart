// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipesHash() => r'b4903247a3ce5a56dbbc5b77aa7b445fe10b0777';

/// See also [recipes].
@ProviderFor(recipes)
final recipesProvider = AutoDisposeFutureProvider<List<Recipe>>.internal(
  recipes,
  name: r'recipesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$recipesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecipesRef = AutoDisposeFutureProviderRef<List<Recipe>>;
String _$breakfastRecipesHash() => r'b40466d62ef7dc819e1077f91f2bafc1c1a1fa71';

/// See also [breakfastRecipes].
@ProviderFor(breakfastRecipes)
final breakfastRecipesProvider =
    AutoDisposeFutureProvider<List<Recipe>>.internal(
  breakfastRecipes,
  name: r'breakfastRecipesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$breakfastRecipesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BreakfastRecipesRef = AutoDisposeFutureProviderRef<List<Recipe>>;
String _$lunchRecipesHash() => r'268beeaa9854b631fd51124f14d92b301136e41a';

/// See also [lunchRecipes].
@ProviderFor(lunchRecipes)
final lunchRecipesProvider = AutoDisposeFutureProvider<List<Recipe>>.internal(
  lunchRecipes,
  name: r'lunchRecipesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$lunchRecipesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LunchRecipesRef = AutoDisposeFutureProviderRef<List<Recipe>>;
String _$dinnerRecipesHash() => r'8091d8c518ff297981310fbb41dd8559c2da6d7a';

/// See also [dinnerRecipes].
@ProviderFor(dinnerRecipes)
final dinnerRecipesProvider = AutoDisposeFutureProvider<List<Recipe>>.internal(
  dinnerRecipes,
  name: r'dinnerRecipesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dinnerRecipesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DinnerRecipesRef = AutoDisposeFutureProviderRef<List<Recipe>>;
String _$foodTypeHash() => r'197d9d9d1b08ebac96ad22d2516d6833a3d780ba';

/// See also [foodType].
@ProviderFor(foodType)
final foodTypeProvider =
    AutoDisposeNotifierProvider<foodType, FoodType>.internal(
  foodType.new,
  name: r'foodTypeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$foodTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$foodType = AutoDisposeNotifier<FoodType>;
String _$recipeNotifierHash() => r'c3fd5719f56f39a60ed06caf1c81d797901aab3d';

/// See also [RecipeNotifier].
@ProviderFor(RecipeNotifier)
final recipeNotifierProvider =
    AutoDisposeNotifierProvider<RecipeNotifier, Recipe>.internal(
  RecipeNotifier.new,
  name: r'recipeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recipeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RecipeNotifier = AutoDisposeNotifier<Recipe>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
