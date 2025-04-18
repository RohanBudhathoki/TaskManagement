import 'package:fpdart/fpdart.dart';

import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';

abstract class TaskRepo {
  Future<Either<Failure, TaskEntity>> uploadTask({
    required String title,
    required String description,
  });

  Stream<Either<Failure, List<TaskEntity>>> getTasks();
  Future<Either<Failure, TaskEntity>> updateTaskStage({
    required String taskStatus,
    required String taskId,
  });

  Future<Either<Failure, TaskEntity>> updatTask({
    required String title,
    required String description,
    required String taskStatus,
    required String taskId,
  });
}
