import 'package:flutter/material.dart';
import 'package:taskmanagementapp/features/auth/presentation/login/login.dart';

Widget buildAlreadyHaveAccount(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    },
    child: RichText(
      text: TextSpan(
        text: 'Already have an account?  ',
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 20),
        children: const [
          TextSpan(
            text: 'SignIn',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    ),
  );
}
