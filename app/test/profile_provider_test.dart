import 'package:firfir_tera/providers/edit_profile_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  group('ProfileNotifier', () {
    test('setImage changes the state', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final profileNotifier = container.read(profileNotifierProvider.notifier);

      // Call setImage
      profileNotifier.setImage('Test Image Data');

      // Check if the state has been changed
      expect(profileNotifier.state.imageData, 'Test Image Data');

      // Dispose the container after use
      container.dispose();
    });

    test('saveChanges updates the state', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final profileNotifier = container.read(profileNotifierProvider.notifier);

      // Set initial values
      profileNotifier.state.nameController.text = 'Test Name';
      profileNotifier.state.emailController.text = 'Test Email';
      profileNotifier.state.bioController.text = 'Test Bio';

      // Call saveChanges
      profileNotifier.saveChanges();

      // Check if the state has been updated
      expect(profileNotifier.state.nameController.text, 'Test Name');
      expect(profileNotifier.state.emailController.text, 'Test Email');
      expect(profileNotifier.state.bioController.text, 'Test Bio');

      // Dispose the container after use
      container.dispose();
    });
  });
}
