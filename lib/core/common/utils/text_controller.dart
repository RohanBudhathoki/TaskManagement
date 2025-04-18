import 'package:flutter/material.dart';

class TextEditingControllers {
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  TextEditingControllers()
    : emailController = TextEditingController(),
      nameController = TextEditingController(),
      passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
