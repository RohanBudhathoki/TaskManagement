import 'package:flutter/material.dart';
import 'package:taskmanagementapp/core/theme/app_colors.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Expanded(
          child: Divider(
            indent: 28.5,
            thickness: 1.43,
            color: AppColors.darkBackGround,
          ),
        ),
        Text(
          'Or sign in with  ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.darkBackGround,
          ),
        ),
        const Expanded(
          child: Divider(
            endIndent: 28.5,
            thickness: 1.43,
            color: AppColors.darkBackGround,
          ),
        ),
      ],
    );
  }
}
