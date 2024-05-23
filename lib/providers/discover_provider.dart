import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discover_provider.g.dart';

@riverpod
class SelectedOption extends _$SelectedOption {
  @override
  String build() => "All";

  void setOption(String option) {
    state = option;
  }
}
