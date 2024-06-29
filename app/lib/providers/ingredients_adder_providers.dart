import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ingredients_adder_providers.g.dart';

@riverpod
class IngredientList extends _$IngredientList {
  @override
  List<TextEditingController> build() =>
      [TextEditingController(), TextEditingController()];

  void addController() {
    state = [...state, TextEditingController(), TextEditingController()];
  }

  void removeController(int index) {
    state = [
      ...state.sublist(0, index),
      ...state.sublist(index + 2),
    ];
  }
}
