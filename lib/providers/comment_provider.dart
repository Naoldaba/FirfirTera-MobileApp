import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/models/Comment.dart';
import 'package:firfir_tera/presentation/services/comment_service.dart';


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
    } catch (e) {}
  }

  Future<void> addComment(Comment comment) async {
    try {
      await _service.addComment(comment);
      state = [...state, comment];
    } catch (e) {}
  }

  Future<void> deleteComment(String commentId) async {
    try {
      await _service.deleteComment(commentId);
      state = state.where((comment) => comment.id != commentId).toList();
    } catch (e) {}
  }

  Future<void> updateComment(Comment updatedComment) async {
    try {
      await _service.updateComment(updatedComment);
      state = state
          .map((comment) => comment.id == updatedComment.id
              ? updatedComment
              : comment)
          .toList();
    } catch (e) {}
  }
}
