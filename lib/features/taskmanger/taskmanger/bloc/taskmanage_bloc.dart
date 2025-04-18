import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/creat_task.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/get_task.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/update_task_stage.dart';
part 'taskmanage_event.dart';
part 'taskmanage_state.dart';

class TaskmanageBloc extends Bloc<TaskmanageEvent, TaskmanageState> {
  final CreatTask _createTask;
  final GetTask _getTask;
  final UpdateTaskStage _updateTaskStage;
  StreamSubscription<Either<Failure, List<TaskEntity>>>? _taskSubscription;

  TaskmanageBloc({
    required CreatTask createTask,
    required GetTask getTask,
    required UpdateTaskStage updateTaskStage,
  }) : _createTask = createTask,
       _getTask = getTask,
       _updateTaskStage = updateTaskStage,
       super(TaskmanageInitial()) {
    on<TaskmanageEvent>((event, emit) {
      TaskmanageLoading();
    });

    on<CreateTaskBloc>(_createTasks);
    on<GetTaskBLoc>(_getTasks);
    on<UpdateTaskStageBloc>(_updateTaskStages);
  }
  void _createTasks(CreateTaskBloc event, Emitter<TaskmanageState> emit) async {
    final res = await _createTask(
      CreateTaskParams(title: event.title, description: event.description),
    );

    res.fold(
      (l) => emit(TaskmanageFailure(l.message)),
      (r) => emit(TaskmanageSucess()),
    );
  }

  void _getTasks(GetTaskBLoc event, Emitter<TaskmanageState> emit) {
    _taskSubscription?.cancel();

    _taskSubscription = _getTask(NoParams()).listen(
      (res) {
        res.fold(
          (l) => emit(TaskmanageFailure(l.message)),
          (r) => emit(TaskManageDisplaySucess(r)),
        );
      },
      onError: (e) {
        emit(TaskmanageFailure("Error: ${e.toString()}"));
      },
    );
  }

  @override
  Future<void> close() {
    _taskSubscription?.cancel();
    return super.close();
  }

  void _updateTaskStages(
    UpdateTaskStageBloc event,
    Emitter<TaskmanageState> emit,
  ) async {
    final res = await _updateTaskStage(
      UpdateTaskStageParams(stautus: event.status, taskId: event.taskId),
    );

    res.fold(
      (l) => emit(TaskmanageFailure(l.message)),
      (r) => emit(TaskmanageSucess()),
    );
  }
}
