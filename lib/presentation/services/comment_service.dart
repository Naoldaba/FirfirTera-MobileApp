// import 'dart:js';

import 'package:firfir_tera/models/Comment.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:flutter/material.dart';

class CommentService {
  final String url = 'https://2076-213-55-95-177.ngrok-free.app';

  Future<List<Comment>> fetchComments(String recipeId) async {
    final response = await http.get(Uri.parse('$url/comments/${recipeId}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((item) => Comment.fromJson(item)).toList();
    } else {
      SnackBar(content: Text("Unable to fetch comments, pls try again later"));
      throw Exception("unable to fetch");
    }
  }

  Future<void> addComment(Comment comment) async {
    print(comment.toJson());
    final response = await http.post(
      Uri.parse('$url/comments/${comment.recipeId}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode != 201) {
      SnackBar(content: Text("Unable to post comment, pls try again later"));
    } else {
      print('success');
      SnackBar(content: Text("Comment successfully created"));
    }
  }

  Future<bool> deleteComment(String commentId) async {
    final response = await http.delete(
      Uri.parse('$url/comments/$commentId'),
    );

    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> updateComment(Comment comment) async {
    String? commentId = comment.id;
    final response = await http.patch(
      Uri.parse('$url/comments/${commentId}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }
}
