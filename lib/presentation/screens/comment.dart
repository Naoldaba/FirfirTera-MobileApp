import 'package:firfir_tera/models/Recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/providers/comment_provider.dart';
import 'package:firfir_tera/models/Comment.dart';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:firfir_tera/models/User.dart';

class CommentScreen extends ConsumerWidget {
  final Recipe recipe;

  CommentScreen({required this.recipe});

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeId = recipe.id;
    User? user = ref.watch(userModelProvider).when(data: (body) {
      print(body.role);
      return body;
    }, error: (e, s) {
      print(e);
    }, loading: () {
      print('loading');
    });
    
    final currentUserId = user!.id;
    final comments = ref.watch(commentsProvider(recipeId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text(comment.text),
                  subtitle: Text('User: ${comment.userId}'),
                  trailing: comment.userId == currentUserId
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _commentController.text = comment.text;
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Edit Comment'),
                                    content: TextField(
                                      controller: _commentController,
                                      decoration: InputDecoration(
                                          hintText: 'Edit your comment'),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(commentsProvider(recipeId)
                                                  .notifier)
                                              .updateComment(
                                                Comment(
                                                  recipeId: comment.recipeId,
                                                  userId: comment.userId,
                                                  text:
                                                      _commentController.text,
                                                ),
                                              );
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Save'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                ref
                                    .read(commentsProvider(recipeId).notifier)
                                    .deleteComment(comment.id!);
                              },
                            ),
                          ],
                        )
                      : null,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(hintText: 'Enter your comment'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final newComment = Comment(
                      recipeId: recipeId,
                      userId: currentUserId,
                      text: _commentController.text,
                    );
                    ref
                        .read(commentsProvider(recipeId).notifier)
                        .addComment(newComment);
                    _commentController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
