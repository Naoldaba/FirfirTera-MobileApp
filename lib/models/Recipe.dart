import 'dart:io';

import 'package:flutter/widgets.dart';

class Recipe {
  final String? id;
  final String name;
  final String description;
  final int cookTime;
  final int people;
  final List<String> ingredients;
  final List<String> steps;
  final bool fasting;
  final String type;
  final String image;

  Recipe({
    this.id,
    required this.name,
    required this.description,
    required this.cookTime,
    required this.people,
    required this.fasting,
    required this.image,
    required this.ingredients,
    required this.steps,
    required this.type,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id:json['id'],
      name: json['name'],
      description: json['description'],
      cookTime: json['cookTime'],
      people: json['people'],
      fasting: json['fasting'],
      image: json['image'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'cookTime': cookTime,
      'people': people,
      'fasting': fasting,
      'image': image,
      'ingredients': ingredients,
      'steps': steps,
      'type': type,
    };
  }

  Recipe copyWith({
    String? name,
    String? description,
    int? cookTime,
    int? people,
    List<String>? ingredients,
    List<String>? steps,
    bool? fasting,
    String? type,
    String? image,
  }) {
    return Recipe(
      id: id?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      cookTime: cookTime ?? this.cookTime,
      people: people ?? this.people,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      fasting: fasting ?? this.fasting,
      type: type ?? this.type,
      image: image ?? this.image,
    );
  }
}

class PatchRecipeParams {
  final BuildContext context;
  final String id;
  final String name;
  final String description;
  final String cookTime;
  final String people;
  final String type;
  final File image;
  final List<String> ingredients;
  final List<String> steps;

  PatchRecipeParams({
    required this.context,
    required this.id,
    required this.name,
    required this.description,
    required this.cookTime,
    required this.people,
    required this.type,
    required this.image,
    required this.ingredients,
    required this.steps,
  });
}

class PostRecipeParams {
  final BuildContext context;
  final String name;
  final String description;
  final String cookTime;
  final String people;
  final String type;
  final File image;
  final List<String> ingredients;
  final List<String> steps;

  PostRecipeParams({
    required this.context,
    required this.name,
    required this.description,
    required this.cookTime,
    required this.people,
    required this.type,
    required this.image,
    required this.ingredients,
    required this.steps,
  });
}
