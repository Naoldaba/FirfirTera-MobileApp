// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$recipeNotifierHash() => r'7e4b7f12b609f3a8eb889a3ae463ddaadb312e5e';

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
