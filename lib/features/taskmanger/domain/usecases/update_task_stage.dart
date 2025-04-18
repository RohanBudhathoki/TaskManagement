import 'package:fpdart/fpdart.dart';

import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/core/usecase/usecases.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/repository/task_repo.dart';

class UpdateTaskStage implements UseCase<TaskEntity, UpdateTaskStageParams> {
  final TaskRepo taskRepo;

  UpdateTaskStage(this.taskRepo);
  @override
  Future<Either<Failure, TaskEntity>> call(UpdateTaskStageParams params) async {
    return await taskRepo.updateTaskStage(
      taskStatus: params.stautus,
      taskId: params.taskId,
    );
  }
}

class UpdateTaskStageParams {
  final String taskId;
  final String stautus;

  UpdateTaskStageParams({required this.stautus, required this.taskId});
}
