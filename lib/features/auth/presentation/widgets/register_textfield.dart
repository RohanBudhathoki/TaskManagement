import 'package:flutter/material.dart';

class RegisterTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;

  final Icon? imagesuffix;
  const RegisterTextfield({
    Key? key,
    this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.obscureText,
    this.imagesuffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        obscureText: obscureText,
        obscuringCharacter: '*',
        keyboardType: keyboardType,
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          suffixIcon: imagesuffix,
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.green, width: 1),
          ),
        ),
      ),
    );
  }
}
