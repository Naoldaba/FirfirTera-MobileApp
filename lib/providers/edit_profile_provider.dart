import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_profile_provider.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  ProfileState build() {
    return ProfileState(
      imageData: null,
      nameController: TextEditingController(),
      emailController: TextEditingController(),
      bioController: TextEditingController(),
    );
  }

  void setImage(String imageData) {
    state = state.copyWith(imageData: imageData);
  }

  void saveChanges() {
    String name = state.nameController.text;
    String email = state.emailController.text;
    String bio = state.bioController.text;

  }
}

class ProfileState {
  final String? imageData;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController bioController;

  ProfileState({
    required this.imageData,
    required this.nameController,
    required this.emailController,
    required this.bioController,
  });

  ProfileState copyWith({
    String? imageData,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? bioController,
  }) {
    return ProfileState(
      imageData: imageData ?? this.imageData,
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      bioController: bioController ?? this.bioController,
    );
  }
}
