import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/enum/task_enum.dart';
import 'package:taskmanagementapp/core/error/exception.dart';
import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/features/taskmanger/data/datasource/task_remote_data_source.dart';
import 'package:taskmanagementapp/features/taskmanger/data/models/task_model.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/repository/task_repo.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskRepoImple implements TaskRepo {
  final TaskRemoteDataSources remoteDataSources;
  final FirebaseAuth auth;
  var uuid = Uuid();

  TaskRepoImple(this.remoteDataSources, this.auth);

  @override
  Future<Either<Failure, TaskEntity>> uploadTask({
    required String title,
    required String description,
  }) async {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        return left(Failure(message: "User not logged in"));
      }

      TaskModel taskModel = TaskModel(
        id: uuid.v1(),
        title: title,
        description: description,
        status: TaskStatus.pending.label,
        userId: userId, // Assign the userId to the task
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
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        yield left(Failure(message: "User not logged in"));
        return;
      }

      final stream = remoteDataSources.getTasks();

      await for (final taskList in stream) {
        final userTasks =
            taskList.where((task) => task.userId == userId).toList();

        print("this is Stream ${userTasks}");
        yield right(userTasks);
      }
    } catch (e) {
      yield left(Failure(message: 'Error fetching tasks: ${e.toString()}'));
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
        return left(Failure(message: "Failed to update task."));
      }
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updatTask({
    required String title,
    required String description,
    required String taskStatus,
    required String taskId,
  }) async {
    try {
      final updateTaskStage = await remoteDataSources.updateTask(
        taskId: taskId,
        status: taskStatus,
        description: description,
        title: title,
      );
      if (updateTaskStage != null) {
        return right(updateTaskStage);
      } else {
        return left(Failure(message: "Failed to update task."));
      }
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
