import 'package:firfir_tera/providers/discover_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  group('SelectedOption', () {
    test('setOption changes the state', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final selectedOption = container.read(selectedOptionProvider.notifier);

      // Call setOption
      selectedOption.setOption('Test Option');

      // Check if the state has been changed
      expect(selectedOption.state, 'Test Option');

      // Dispose the container after use
      container.dispose();
    });

    test('setOption changes the state for second time ', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final selectedOption = container.read(selectedOptionProvider.notifier);

      // Call setOption
      selectedOption.setOption('Test Option');

      // Check if the state has been changed
      expect(selectedOption.state, 'Test Option');

      // Dispose the container after use
      container.dispose();
    });
  });
}
