import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanagementapp/dependecy_injetion.dart';
import 'package:taskmanagementapp/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';
import 'package:taskmanagementapp/task_management_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initDependecies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocater<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocater<TaskmanageBloc>()),
      ],
      child: const TaskManagementApp(),
    ),
  );
}
