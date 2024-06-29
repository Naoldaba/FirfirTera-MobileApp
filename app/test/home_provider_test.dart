import 'package:firfir_tera/providers/home_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  group('SelectedIndex', () {
    test('build returns initial index', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final selectedIndex = container.read(selectedIndexProvider);

      // Call build
      final index = selectedIndex;

      // Check if the build method returns the initial index
      expect(index, 0);

      // Dispose the container after use
      container.dispose();
    });

    test('build returns initial index', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final selectedIndex = container.read(selectedIndexProvider);

      // Call build
      final index = selectedIndex;

      // Check if the build method returns the initial index
      expect(index, 0);

      // Dispose the container after use
      container.dispose();
    });
  });
}
