import 'dart:convert';

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
  final TextEditingController _editController = TextEditingController();

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
    print("my data = ${comments}");

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
                  title: Text(comment.comment),
                  leading: CircleAvatar(
                      child: Image.network(comment.user_inf['image'])),
                  subtitle: Text('User: ${comment.user_inf['firstName']}'),
                  trailing: comment.user_inf['id'] == currentUserId
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Edit Comment'),
                                    content: TextField(
                                      controller: _editController,
                                      decoration: InputDecoration(
                                          hintText: 'Edit your comment'),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          bool res = await ref
                                              .read(commentsProvider(recipeId)
                                                  .notifier)
                                              .updateComment(
                                                Comment(
                                                  id: comment.id,
                                                  recipeId: comment.recipeId,
                                                  user_inf: comment.user_inf,
                                                  comment: _editController.text,
                                                ),
                                              );
                                          if (res) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'successfully updated comment')));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Unable to update the comment')));
                                          }

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
                              onPressed: () async {
                                bool res = await ref
                                    .read(commentsProvider(recipeId).notifier)
                                    .deleteComment(comment.id!);
                                if (res) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'successfully deleted comment')));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Unable to delete the comment')));
                                }
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
                  onPressed: () async {
                    final newComment = Comment(
                      recipeId: recipeId,
                      user_inf: user.toJson(),
                      comment: _commentController.text,
                    );
                    bool res = await ref
                        .read(commentsProvider(recipeId).notifier)
                        .addComment(newComment);
                    _commentController.clear();

                    if (res) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('successfully posted comment')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Unable to post the comment')));
                    }
                    ref.refresh(commentsProvider(recipeId));
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
