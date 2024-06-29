import 'package:firfir_tera/presentation/services/comment_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/models/Comment.dart';

final commentServiceProvider = Provider((ref) => CommentService());

final commentsProvider =
    StateNotifierProvider.family<CommentNotifier, List<Comment>, String>(
        (ref, recipeId) {
  final service = ref.watch(commentServiceProvider);
  return CommentNotifier(service, recipeId);
});

class CommentNotifier extends StateNotifier<List<Comment>> {
  final CommentService _service;
  final String _recipeId;

  CommentNotifier(this._service, this._recipeId) : super([]) {
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      state = await _service.fetchComments(_recipeId);
      print("state=$state");
    } catch (e) {}
  }

  Future<bool> addComment(Comment comment) async {
    try {
      await _service.addComment(comment);
      state = [...state, comment];
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteComment(String commentId) async {
    try {
      await _service.deleteComment(commentId);
      state = state.where((comment) => comment.id != commentId).toList();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateComment(Comment updatedComment) async {
    try {
      await _service.updateComment(updatedComment);
      state = state
          .map((comment) =>
              comment.id == updatedComment.id ? updatedComment : comment)
          .toList();
      return true;
    } catch (e) {
      return false;
    }
  }
}
