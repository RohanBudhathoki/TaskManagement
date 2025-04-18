import 'package:flutter/material.dart';
import 'package:taskmanagementapp/core/theme/app_theme.dart';

import 'package:taskmanagementapp/features/auth/presentation/login/login.dart';

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkThemData,
      themeMode: ThemeMode.system,
      home: LoginScreen(),
    );
  }
}
