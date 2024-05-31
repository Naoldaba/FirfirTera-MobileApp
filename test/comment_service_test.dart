import 'package:firfir_tera/models/Comment.dart';
import 'package:firfir_tera/presentation/services/comment_service.dart';
import 'package:firfir_tera/providers/comment_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';

class MockCommentService extends Mock implements CommentService {
  @override
  Future<void> addComment(Comment comment) async {}

  @override
  Future<void> deleteComment(String commentId) async {}

  @override
  Future<List<Comment>> fetchComments(String recipeId) async {
    return [];
  }
}

void main() {
  group('CommentNotifier', () {
    test('initial state is empty', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final commentNotifier = container.read(commentsProvider('testRecipeId'));

      // Check if the initial state is empty
      expect(commentNotifier, isEmpty);

      // Dispose the container after use
      container.dispose();
    });

    test('add comment', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final commentNotifier = container.read(commentsProvider('testRecipeId'));

      // Check if the initial state is empty
      expect(commentNotifier, isEmpty);

      // Dispose the container after use
      container.dispose();
    });
  });
}
