import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_details_provider.g.dart';

@riverpod
class IsBanned extends _$IsBanned {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }
}

@riverpod
class IsPromoted extends _$IsPromoted {
  @override
  bool build() => false;
  void toggle() {
    state = !state;
  }
}
