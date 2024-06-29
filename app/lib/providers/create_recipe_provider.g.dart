// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_recipe_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ingredientsNotifierHash() =>
    r'79867dde951088f15edda99dd32f88a79eba2226';

/// See also [IngredientsNotifier].
@ProviderFor(IngredientsNotifier)
final ingredientsNotifierProvider =
    AutoDisposeNotifierProvider<IngredientsNotifier, List<Ingredient>>.internal(
  IngredientsNotifier.new,
  name: r'ingredientsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ingredientsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IngredientsNotifier = AutoDisposeNotifier<List<Ingredient>>;
String _$stepNotifierHash() => r'd0f24e945de44772cd5308211b9ad807a0acda2d';

/// See also [StepNotifier].
@ProviderFor(StepNotifier)
final stepNotifierProvider =
    AutoDisposeNotifierProvider<StepNotifier, List<Step>>.internal(
  StepNotifier.new,
  name: r'stepNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$stepNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StepNotifier = AutoDisposeNotifier<List<Step>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
