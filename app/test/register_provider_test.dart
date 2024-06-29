import 'package:firfir_tera/providers/registration_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  group('RegisterOne', () {
    test('addValue adds a value to firstPageMap', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final registerOne = container.read(registerOneProvider.notifier);

      // Call addValue
      registerOne.addValue({'key': 'value'});

      // Check if the firstPageMap has the added value
      expect(registerOne.build(), {'key': 'value'});

      // Dispose the container after use
      container.dispose();
    });
  });

  group('RegisterTwo', () {
    test('addValue adds a value to secondPageMap', () {
      // Create a container
      final container = ProviderContainer();

      // Override the provider
      final registerTwo = container.read(registerTwoProvider.notifier);

      // Call addValue
      registerTwo.addValue({'key': 'value'});

      // Check if the secondPageMap has the added value
      expect(registerTwo.build(), {'key': 'value'});

      // Dispose the container after use
      container.dispose();
    });
  });
}
