import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/core/usecase/usecases.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/repository/task_repo.dart';

class UpdateTask implements UseCase<TaskEntity, UpdateTaskParams> {
  final TaskRepo taskRepo;

  UpdateTask(this.taskRepo);

  @override
  Future<Either<Failure, TaskEntity>> call(UpdateTaskParams params) async {
    return await taskRepo.updatTask(
      title: params.title,
      description: params.description,
      taskStatus: params.stautus,
      taskId: params.taskId,
    );
  }
}

class UpdateTaskParams {
  final String description;
  final String title;
  final String taskId;
  final String stautus;

  UpdateTaskParams({
    required this.description,
    required this.taskId,
    required this.stautus,
    required this.title,
  });
}
