part of 'taskmanage_bloc.dart';

@immutable
sealed class TaskmanageState {}

final class TaskmanageInitial extends TaskmanageState {}

final class TaskmanageLoading extends TaskmanageState {}

final class TaskmanageSucess extends TaskmanageState {}

final class TaskmanageFailure extends TaskmanageState {
  final String message;
  TaskmanageFailure(this.message);
}

final class TaskManageDisplaySucess extends TaskmanageState {
  final List<TaskEntity> task;

  TaskManageDisplaySucess(this.task);
}

final class TaskStageUpdateState extends TaskmanageState {}

class TaskManageViewToggled extends TaskmanageState {
  final bool isKanbanView;

  TaskManageViewToggled(this.isKanbanView);
}
