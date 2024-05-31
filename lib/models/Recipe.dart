import 'dart:io';
import 'package:flutter/Widgets.dart';

class Recipe {
  final String id;
  final String name;
  final String description;
  final int cookTime;
  final int people;
  final List<String> ingredients;
  final List<String> steps;
  final bool fasting;
  final String type;
  final String image;
  String? cookId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.cookTime,
    required this.people,
    required this.ingredients,
    required this.steps,
    required this.fasting,
    required this.type,
    required this.image,
    this.cookId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      cookTime: json['cookTime'],
      people: json['people'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      fasting: json['fasting'] == 'true',
      type: json['type'],
      image: json['image'],
      cookId: json['cook_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': {'\$oid': id},
      'name': name,
      'description': description,
      'cookTime': cookTime,
      'people': people,
      'ingredients': ingredients,
      'steps': steps,
      'fasting': fasting.toString(),
      'type': type,
      'image': image,
      'cook_id': cookId,
      'createdAt': {'\$date': createdAt!.toIso8601String()},
      'updatedAt': {'\$date': updatedAt!.toIso8601String()},
      '__v': v,
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
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      cookTime: cookTime ?? this.cookTime,
      people: people ?? this.people,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      fasting: fasting ?? this.fasting,
      type: type ?? this.type,
      image: image ?? this.image,
      cookId: cookId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
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
  final bool fasting;
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
    required this.fasting,
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
  final bool fasting;
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
    required this.fasting,
    required this.image,
    required this.ingredients,
    required this.steps,
  });
}
