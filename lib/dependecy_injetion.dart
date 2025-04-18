import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import 'package:taskmanagementapp/features/taskmanger/data/datasource/task_remote_data_source.dart';
import 'package:taskmanagementapp/features/taskmanger/data/repository/task_repo_implementation.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/repository/task_repo.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/creat_task.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/get_task.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/update_task_stage.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';

GetIt serviceLocater = GetIt.instance;
Future<void> initDependecies() async {
  _initTask();
}

void _initTask() {
  serviceLocater
    ..registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance)
    ..registerFactory<TaskRemoteDataSources>(
      () => TaskDataSource(serviceLocater()),
    )
    ..registerFactory<TaskRepo>(() => TaskRepoImple(serviceLocater()))
    ..registerFactory(() => CreatTask(serviceLocater()))
    ..registerFactory(() => GetTask(serviceLocater()))
    ..registerFactory(() => UpdateTaskStage(serviceLocater()))
    ..registerFactory(
      () => TaskmanageBloc(
        createTask: serviceLocater(),
        getTask: serviceLocater(),
        updateTaskStage: serviceLocater(),
      ),
    );
}
