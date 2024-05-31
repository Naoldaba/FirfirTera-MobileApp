import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

Future<bool> DeleteRecipe(String id) async {
  final response = await http.delete(Uri.parse(''));
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
    final url = Uri.parse('');
    final request = http.MultipartRequest('PATCH', url);

    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['cookTime'] = cookTime;
    request.fields['people'] = people;
    request.fields['type'] = type;
    request.fields['ingredients'] = jsonEncode(ingredients);
    request.fields['steps'] = jsonEncode(steps);

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      image.path,
      filename: basename(image.path),
      contentType: MediaType('image', 'jpeg'),
    ));

    final response = await request.send();
    // print(request.fields);
    // print(request.files);

    // final response = true;
    if (response.statusCode==200) {
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
    final url = Uri.parse('');
    final request = http.MultipartRequest('POST', url);

    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['cookTime'] = cookTime;
    request.fields['people'] = people;
    request.fields['type'] = type;
    request.fields['ingredients'] = jsonEncode(ingredients);
    request.fields['steps'] = jsonEncode(steps);

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      image.path,
      filename: basename(image.path),
      contentType: MediaType('image', 'jpeg'),
    ));

    final response = await request.send();
    // print(request.fields);
    // print(request.fields);
    // final response = true;

    if (response.statusCode==200) {
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
