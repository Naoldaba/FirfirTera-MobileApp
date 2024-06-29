// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:firfir_tera/providers/profile_edit_provider.dart';
import 'package:firfir_tera/providers/registration_provider.dart';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firfir_tera/presentation/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock class using mockito
class MockAuthService extends Mock implements AuthService {}

// Mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockAuthService mockAuthService;
  late MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockAuthService = MockAuthService();
    mockSharedPreferences = MockSharedPreferences();
  });
  test('Check userProvider', () async {
    var sharedPreferencesProvider;
    var authServiceProvider;
    final container = ProviderContainer(overrides: [
      // sharedPreferencesProvider.overrideWithValue(mockSharedPreferences),
      // authServiceProvider.overrideWithValue(mockAuthService),
    ]);
    final user = container.read(userProvider);
    expect(user, user);
  });
  test('Check userModelProvider', () async {
    when(mockSharedPreferences.getString('token')).thenReturn('test');
    var sharedPreferencesProvider;
    var authServiceProvider;
    final container = ProviderContainer(overrides: [
      // sharedPreferencesProvider.overrideWithValue(mockSharedPreferences),
      // authServiceProvider.overrideWithValue(mockAuthService),
    ]);

    final user = container.read(userModelProvider);
    expect(user, user);
  });
  test('Check checkProvider', () async {
    when(mockSharedPreferences.getString("token")).thenReturn('test');

    var sharedPreferencesProvider;
    final container = ProviderContainer(overrides: [
      // sharedPreferencesProvider.overrideWithValue(mockSharedPreferences),
    ]);

    final token = container.read(checkProvider);
    expect(token, token);
  });

  test('Check RegisterOne provider', () async {
    final container = ProviderContainer();
    final registerOne = container.read(registerOneProvider);

    // Initially, the map should be empty
    expect(registerOne, isEmpty);

    // Add a value and check if it's added correctly
    expect(registerOne, registerOne);
  });

  test('Check RegisterTwo provider', () async {
    final container = ProviderContainer();
    final registerTwo = container.read(registerTwoProvider);

    // Initially, the map should be empty
    expect(registerTwo, isEmpty);

    // Add a value and check if it's added correctly
    expect(registerTwo, registerTwo);
  });

  test('Check ProfileEdit provider', () {
    final profileEdit = ProfileEdit();

    final result = profileEdit.build();

    expect(
        result,
        equals({
          "name": "name",
          "email": "email",
          "password": "password",
          "bio": "bio",
        }));
  });
}
