// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipesHash() => r'5007d0cadb22fa23c65b270552e9ceb892381075';

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
String _$breakfastRecipesHash() => r'91039afdadd82cb548bf0f1f63cb8f434ea01c69';

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
String _$lunchRecipesHash() => r'30b95d94a28d109be343b8f46cda174383c58f33';

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
String _$dinnerRecipesHash() => r'84775c870cd498407ee3dfd2dbc968a5d18412c2';

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
String _$recipeNotifierHash() => r'efa3d6ae6c30e0d690ef96571218c1e5f7823192';

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
