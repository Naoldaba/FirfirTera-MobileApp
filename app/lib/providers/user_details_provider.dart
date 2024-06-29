import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_details_provider.g.dart';

@riverpod
class IsSuccess extends _$IsSuccess {
  @override
  bool build() {
    return true;
  }

  void changeState(ans) {
    state = ans;
  }
}
