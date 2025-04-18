part of 'taskmanage_bloc.dart';

@immutable
sealed class TaskmanageEvent {}

final class CreateTaskBloc extends TaskmanageEvent {
  final String title;
  final String description;

  CreateTaskBloc({required this.title, required this.description});
}

final class GetTaskBLoc extends TaskmanageEvent {}

final class UpdateTaskStageBloc extends TaskmanageEvent {
  final String taskId;
  final String status;

  UpdateTaskStageBloc({required this.taskId, required this.status});
}

class ToggleViewEvent extends TaskmanageEvent {}

final class UpdateTaskBloc extends TaskmanageEvent {
  final String taskId;
  final String status;
  final String title;
  final String description;

  UpdateTaskBloc(
    this.title,
    this.description, {
    required this.taskId,
    required this.status,
  });
}
