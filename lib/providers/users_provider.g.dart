// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allUsersHash() => r'd7ce2dd331fe6e5291e0ae9d554bcf4ab15bb5bf';

/// See also [allUsers].
@ProviderFor(allUsers)
final allUsersProvider = AutoDisposeFutureProvider<List<User>>.internal(
  allUsers,
  name: r'allUsersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllUsersRef = AutoDisposeFutureProviderRef<List<User>>;
String _$userStateHash() => r'e90905a9ce55994d717c88a914994de24d82be25';

/// See also [UserState].
@ProviderFor(UserState)
final userStateProvider = AutoDisposeNotifierProvider<UserState, User>.internal(
  UserState.new,
  name: r'userStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserState = AutoDisposeNotifier<User>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
