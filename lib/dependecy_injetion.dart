import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:taskmanagementapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskmanagementapp/features/auth/data/repository/auth_repo_implementation.dart';
import 'package:taskmanagementapp/features/auth/domain/repository/auth_repo.dart';
import 'package:taskmanagementapp/features/auth/domain/usecases/curret_user.dart';
import 'package:taskmanagementapp/features/auth/domain/usecases/user_login.dart';
import 'package:taskmanagementapp/features/auth/domain/usecases/user_signout.dart';
import 'package:taskmanagementapp/features/auth/domain/usecases/user_signup.dart';
import 'package:taskmanagementapp/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:taskmanagementapp/features/taskmanger/data/datasource/task_remote_data_source.dart';
import 'package:taskmanagementapp/features/taskmanger/data/repository/task_repo_implementation.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/repository/task_repo.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/creat_task.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/get_task.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/update_task.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/update_task_stage.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';

GetIt serviceLocater = GetIt.instance;
Future<void> initDependecies() async {
  serviceLocater.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  serviceLocater.registerLazySingleton(() => FirebaseAuth.instance);

  _initAuth();

  _initTask();
}

void _initAuth() {
  serviceLocater
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocater<FirebaseAuth>(),
        serviceLocater<FirebaseFirestore>(),
      ),
    )
    ..registerFactory<AuthRepo>(
      () => AuthRepoImple(
        serviceLocater<AuthRemoteDataSource>(),
        serviceLocater<FirebaseAuth>(),
        serviceLocater<FirebaseFirestore>(),
      ),
    )
    ..registerFactory(() => UserSignUp(serviceLocater()))
    ..registerFactory(() => UserLogin(serviceLocater()))
    ..registerFactory(() => UserCurrent(serviceLocater()))
    ..registerFactory(() => UserLogout(serviceLocater()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignup: serviceLocater(),
        userLogin: serviceLocater(),
        userLogout: serviceLocater(),
      ),
    );
}

void _initTask() {
  serviceLocater
    ..registerFactory<TaskRemoteDataSources>(
      () => TaskDataSource(
        serviceLocater<FirebaseFirestore>(),
        serviceLocater<FirebaseAuth>(),
      ),
    )
    ..registerFactory<TaskRepo>(
      () => TaskRepoImple(
        serviceLocater<TaskRemoteDataSources>(),
        serviceLocater<FirebaseAuth>(),
      ),
    )
    ..registerFactory(() => CreatTask(serviceLocater()))
    ..registerFactory(() => GetTask(serviceLocater()))
    ..registerFactory(() => UpdateTaskStage(serviceLocater()))
    ..registerFactory(() => UpdateTask(serviceLocater()))
    ..registerFactory(
      () => TaskmanageBloc(
        createTask: serviceLocater(),
        getTask: serviceLocater(),
        updateTaskStage: serviceLocater(),
        updateTask: serviceLocater(),
      ),
    );
}
