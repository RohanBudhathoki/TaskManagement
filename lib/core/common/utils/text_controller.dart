import 'package:flutter/material.dart';

class TextEditingControllers {
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  TextEditingControllers()
    : emailController = TextEditingController(),
      nameController = TextEditingController(),
      passwordController = TextEditingController(),
      titleController = TextEditingController(),
      descriptionController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
}
