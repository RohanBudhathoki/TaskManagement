import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/core/usecase/usecases.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/repository/task_repo.dart';

class CreatTask implements UseCase<TaskEntity, CreateTaskParams> {
  final TaskRepo taskRepo;

  CreatTask(this.taskRepo);
  @override
  Future<Either<Failure, TaskEntity>> call(CreateTaskParams params) async {
    return await taskRepo.uploadTask(
      title: params.title,
      description: params.description,
    );
  }
}

class CreateTaskParams {
  final String title;
  final String description;

  CreateTaskParams({required this.title, required this.description});
}
