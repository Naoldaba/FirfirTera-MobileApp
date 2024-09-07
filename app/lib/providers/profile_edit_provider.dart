import 'package:firfir_tera/presentation/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_edit_provider.g.dart';

@riverpod
class ProfileEdit extends _$ProfileEdit {
  @override
  Map<String, dynamic> build() {
    return {
      "firstName": "",
      "lastName": "",
    };
  }

  void overrideAll(Map<String, dynamic> data, BuildContext context) {
    state = {
      ...state,
      "firstName": data["firstName"],
      "lastName": data["lastName"],
    };
    sendPatch(context);
  }

  void sendPatch(BuildContext context) {
    AuthService authService = AuthService();
    authService.patchUser(state, context);
  }
}
