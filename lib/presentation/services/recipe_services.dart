import 'dart:convert';
import 'dart:io';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:firfir_tera/models/Recipe.dart';

const String url = 'https://2076-213-55-95-177.ngrok-free.app';

class RecipeServices {
  Future<List<Recipe>> recipes() async {
    print("here");
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
    final response = await http.delete(
      Uri.parse('$url/recipes/${id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
      },
    );
    if (response.statusCode == 200) {
      print('Recipe deleted');
      return true;
    } else {
      print('Failed to delete recipe. Status code: ${response.statusCode}');
      return false;
    }
  }

  Future<bool> sendPatchRequest({
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
    final request =
        http.MultipartRequest('PATCH', Uri.parse('$url/recipes/$id'));

    request.headers['Authorization'] =
        'Bearer ${sharedPreferences.getString('token')}';

    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['cookTime'] = cookTime;
    request.fields['people'] = people;
    request.fields['type'] = type.split('.')[1];
    request.fields['fasting'] = fasting.toString();
    request.fields['ingredients'] = jsonEncode(ingredients);
    request.fields['steps'] = jsonEncode(ingredients);

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
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendPostRequest({
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
    final request =
        http.MultipartRequest('POST', Uri.parse('$url/recipes/new'));

    // request.headers['Content-Type'] = 'application/json';
    request.headers['Authorization'] =
        'Bearer ${sharedPreferences.getString('token')}';
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['cookTime'] = cookTime;
    request.fields['people'] = people;
    request.fields['type'] = type.split('.')[1];
    List<String> new_ing =
        ingredients.where((element) => element != "").toList();
    List<String> new_steps = steps.where((element) => element != "").toList();
    request.fields['ingredients'] = jsonEncode(new_ing);
    request.fields['steps'] = jsonEncode(new_steps);

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      image.path,
      filename: basename(image.path),
      contentType: MediaType('image', 'jpeg'),
    ));

    print(request.fields);
    print(request.files);

    final response = await request.send();

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
