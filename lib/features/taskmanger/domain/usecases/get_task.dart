import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/core/usecase/stream_usecases.dart';

import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/repository/task_repo.dart';

class GetTask implements StreamUseCase<List<TaskEntity>, NoParams> {
  final TaskRepo taskRepo;

  GetTask(this.taskRepo);
  @override
  Stream<Either<Failure, List<TaskEntity>>> call(NoParams params) {
    return taskRepo.getTasks();
  }
}

class NoParams {}
