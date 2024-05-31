import 'package:firfir_tera/models/Comment.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

class CommentService {
  final String url = 'https://289d-213-55-95-222.ngrok-free.app';

  Future<List<Comment>> fetchComments(String recipeId) async {
    // return [
    //   Comment(id: '1', recipeId: recipeId, userId: 'user1', comment: 'Great recipe!'),
    //   Comment(id:'2', recipeId: recipeId, userId: 'user2', comment: 'Loved it!'),
    // ];

    final response = await http.get(Uri.parse('$url/comments/${recipeId}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((item) => Comment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<void> addComment(Comment comment) async {
    print(comment.text);
    final response = await http.post(
      Uri.parse('$url/comments/${comment.recipeId}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add comment');
    } else {
      print('success');
    }
  }

  Future<void> deleteComment(String commentId) async {
    final response = await http.delete(
      Uri.parse('$url/comments/$commentId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete comment');
    }
  }

  Future<void> updateComment(Comment comment) async {
    final response = await http.put(
      Uri.parse('$url/comments/${comment.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update comment');
    }
  }
}
