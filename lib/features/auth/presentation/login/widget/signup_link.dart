import 'package:flutter/material.dart';
import 'package:taskmanagementapp/features/auth/presentation/signup/sign_up.dart';

Widget buildSignUpLink(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignUpScreen()),
      );
    },
    child: RichText(
      text: TextSpan(
        text: 'Don’t have an account?  ',
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 20),
        children: const [
          TextSpan(
            text: 'Signup',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    ),
  );
}
