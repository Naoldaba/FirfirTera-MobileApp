import 'dart:convert';
import 'dart:io';
import 'package:firfir_tera/providers/recipe_provider.dart';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:firfir_tera/models/Recipe.dart';

const String url = 'https://7f7a-213-55-95-169.ngrok-free.app';

class RecipeServices {
  Future<List<Recipe>> recipes() async {
    final response = await http.get(
      Uri.parse("$url/recipes"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
      },
    );
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        print(data);
        return data.map((recipe) => Recipe.fromJson(recipe)).toList();
      } else {
        throw Exception("");
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<Recipe>> breakfastRecipes() async {
    final response = await http.get(Uri.parse("$url/recipes"));
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data
            .map((recipe) => Recipe.fromJson(recipe))
            .where((recipe) => recipe.type == 'breakfast')
            .toList();
      } else {
        throw Exception("");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Recipe>> lunchRecipes() async {
    final response = await http.get(Uri.parse("$url/recipes"));
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data
            .map((recipe) => Recipe.fromJson(recipe))
            .where((recipe) => recipe.type == 'lunch')
            .toList();
      } else {
        throw Exception("");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Recipe>> dinnerRecipes() async {
    final response = await http.get(Uri.parse("$url/recipes"));
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data
            .map((recipe) => Recipe.fromJson(recipe))
            .where((recipe) => recipe.type == 'dinner')
            .toList();
      } else {
        throw Exception("");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> DeleteRecipe(String id) async {
    final response = await http.delete(Uri.parse('$url/recipes/${id}'));
    if (response.statusCode == 204) {
      print('Recipe deleted');
      return true;
    } else {
      print('Failed to delete recipe. Status code: ${response.statusCode}');
      return false;
    }
  }

  Future<void> sendPatchRequest({
    required BuildContext context,
    required String name,
    required String description,
    required String cookTime,
    required String people,
    required String type,
    required bool fasting,
    required File image,
    required List<String> ingredients,
    required List<String> steps,
    required String? id,
  }) async {
    if (name.isNotEmpty &&
        description.isNotEmpty &&
        cookTime.isNotEmpty &&
        people.isNotEmpty &&
        type.isNotEmpty &&
        ingredients.isNotEmpty &&
        steps.isNotEmpty) {
      final request =
          http.MultipartRequest('PATCH', Uri.parse('$url/recipes/$id'));

      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] =
          'Bearer ${sharedPreferences.getString('token')}';

      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['cookTime'] = cookTime;
      request.fields['people'] = people;
      request.fields['type'] = type.split('.')[1];
      request.fields['fasting'] = fasting.toString();
      request.fields['ingredients'] = jsonEncode(ingredients);
      request.fields['steps'] = jsonEncode(steps);

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        filename: basename(image.path),
        contentType: MediaType('image', 'jpeg'),
      ));

      final response = await request.send();
      print(request.fields);
      print(request.files);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recipe updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update recipe')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
    }
  }

  Future<void> sendPostRequest({
    required BuildContext context,
    required String name,
    required String description,
    required String cookTime,
    required String people,
    required String type,
    required bool fasting,
    required File image,
    required List<String> ingredients,
    required List<String> steps,
  }) async {
    if (name.isNotEmpty &&
        description.isNotEmpty &&
        cookTime.isNotEmpty &&
        people.isNotEmpty &&
        type.isNotEmpty &&
        ingredients.isNotEmpty &&
        steps.isNotEmpty) {

      final request = http.MultipartRequest('POST', Uri.parse('$url/recipes/new'));

      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] =
          'Bearer ${sharedPreferences.getString('token')}';
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['cookTime'] = cookTime;
      request.fields['people'] = people;
      request.fields['type'] = type.split('.')[1];
      request.fields['ingredients'] = jsonEncode(ingredients);
      request.fields['steps'] = jsonEncode(steps);

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        filename: basename(image.path),
        contentType: MediaType('image', 'jpeg'),
      ));

      print(request.fields);
      print(request.files);

      final response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recipe created successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create recipe')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill the remaining fields')),
      );
    }
  }
}
