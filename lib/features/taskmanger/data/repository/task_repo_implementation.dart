import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/enum/task_enum.dart';
import 'package:taskmanagementapp/core/error/exception.dart';
import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/features/taskmanger/data/datasource/task_remote_data_source.dart';
import 'package:taskmanagementapp/features/taskmanger/data/models/task_model.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';

import 'package:taskmanagementapp/features/taskmanger/domain/repository/task_repo.dart';
import 'package:uuid/uuid.dart';

class TaskRepoImple implements TaskRepo {
  final TaskRemoteDataSources remoteDataSources;
  var uuid = Uuid();

  TaskRepoImple(this.remoteDataSources);

  @override
  Future<Either<Failure, TaskEntity>> uploadTask({
    required String title,
    required String description,
  }) async {
    try {
      TaskModel taskModel = TaskModel(
        id: uuid.v1(),
        title: title,
        description: description,
        status: TaskStatus.pending.label,
      );

      final uploadedTask = await remoteDataSources.create(taskModel);

      if (uploadedTask != null) {
        return right(uploadedTask);
      } else {
        return left(Failure(message: "Failed to upload task."));
      }
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Stream<Either<Failure, List<TaskEntity>>> getTasks() async* {
    try {
      await for (final taskList in remoteDataSources.getTasks()) {
        yield right<Failure, List<TaskEntity>>(taskList);
      }
    } on ServerException catch (e) {
      yield left<Failure, List<TaskEntity>>(Failure(message: e.toString()));
    } catch (e) {
      yield left<Failure, List<TaskEntity>>(
        Failure(message: "Unexpected error: ${e.toString()}"),
      );
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTaskStage({
    required String taskStatus,
    required String taskId,
  }) async {
    try {
      final updateTaskStage = await remoteDataSources.updateTaskStage(
        taskId: taskId,
        status: taskStatus,
      );
      if (updateTaskStage != null) {
        return right(updateTaskStage);
      } else {
        return left(Failure(message: "Failed to upload task."));
      }
    } on ServerException catch (e) {
      throw e.message.toString();
    }
  }
}
