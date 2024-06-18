import 'package:firfir_tera/models/User.dart';
import 'package:firfir_tera/presentation/services/auth_service.dart';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_edit_provider.g.dart';



final Map<String, dynamic > json = {
  "name": "name",
  "email": "email",
  "password": "password",
  "bio": "bio",
};

@riverpod
class ProfileEdit extends _$ProfileEdit {
  @override
   Map<String, dynamic> build() {
    return json;
   }

   void ovverideAll(Map<String,dynamic> data, BuildContext context){
     json['name'] = data['name'];
      json['email'] = data['email'];
      json['bio'] = data['bio'];
      sendPatch(context);
   }

   void sendPatch(context){
    AuthService authService = AuthService();
    authService.patchUser(json, context);
   }

}
