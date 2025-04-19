import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/creat_task.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/get_task.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/update_task.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/update_task_stage.dart';
part 'taskmanage_event.dart';
part 'taskmanage_state.dart';

class TaskmanageBloc extends Bloc<TaskmanageEvent, TaskmanageState> {
  final CreatTask _createTask;
  final GetTask _getTask;
  final UpdateTaskStage _updateTaskStage;
  final UpdateTask _updateTask;
  StreamSubscription<Either<Failure, List<TaskEntity>>>? _taskSubscription;
  bool isKanbanView = false;
  TaskmanageBloc({
    required CreatTask createTask,
    required GetTask getTask,
    required UpdateTaskStage updateTaskStage,
    required UpdateTask updateTask,
  }) : _createTask = createTask,
       _getTask = getTask,
       _updateTaskStage = updateTaskStage,
       _updateTask = updateTask,
       super(TaskmanageInitial()) {
    on<TaskmanageEvent>((event, emit) {
      emit(TaskmanageLoading());
    });

    on<CreateTaskBloc>(_createTasks);
    on<GetTaskBLoc>(_getTasks);
    on<UpdateTaskStageBloc>(_updateTaskStages);
    on<ToggleViewEvent>(_toggleView);
    on<UpdateTaskBloc>(_updateTasks);
  }
  void _createTasks(CreateTaskBloc event, Emitter<TaskmanageState> emit) async {
    emit(TaskmanageLoading());
    final res = await _createTask(
      CreateTaskParams(title: event.title, description: event.description),
    );

    res.fold(
      (l) => emit(TaskmanageFailure(l.message)),
      (r) => emit(TaskmanageSucess()),
    );
  }

  void _toggleView(ToggleViewEvent event, Emitter<TaskmanageState> emit) {
    isKanbanView = !isKanbanView;
    emit(TaskManageViewToggled(isKanbanView));
  }

  void _getTasks(GetTaskBLoc event, Emitter<TaskmanageState> emit) async {
    emit(TaskmanageLoading());

    try {
      await emit.forEach<Either<Failure, List<TaskEntity>>>(
        _getTask(NoParams()),
        onData: (res) {
          return res.fold(
            (l) => TaskmanageFailure(l.message),
            (r) => TaskManageDisplaySucess(r),
          );
        },
        onError: (error, _) => TaskmanageFailure("Error: ${error.toString()}"),
      );
    } catch (e) {
      emit(TaskmanageFailure("Unexpected error: $e"));
    }
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

  void _updateTasks(UpdateTaskBloc event, Emitter<TaskmanageState> emit) async {
    emit(TaskmanageLoading());

    final res = await _updateTask(
      UpdateTaskParams(
        stautus: event.status,
        taskId: event.taskId,
        description: event.description,
        title: event.title,
      ),
    );

    res.fold(
      (l) {
        emit(TaskmanageFailure(l.message));
      },
      (r) {
        emit(TaskStageUpdateState());
      },
    );
  }
}
