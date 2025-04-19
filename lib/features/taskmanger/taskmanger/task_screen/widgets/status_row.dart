import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/widgets/task_card.dart';
import 'package:taskmanagementapp/core/theme/app_colors.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';
import 'package:taskmanagementapp/core/enum/task_enum.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/display_task/display_task.dart';

class StatusRow extends StatelessWidget {
  final TaskStatus status;
  final List<TaskEntity> tasks;

  const StatusRow({required this.status, required this.tasks, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DragTarget<TaskEntity>(
        onAcceptWithDetails: (task) {
          context.read<TaskmanageBloc>().add(
            UpdateTaskStageBloc(taskId: task.data.id, status: status.label),
          );
        },
        builder: (context, candidateData, rejectedData) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: status.cardColor,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.label,
                    style: TextStyle(
                      color: status.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: AppColors.whiteColor),
                  tasks.isEmpty
                      ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: Text("No tasks")),
                      )
                      : Flexible(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            bool isLandscape =
                                constraints.maxWidth > constraints.maxHeight;

                            double taskCardWidth =
                                isLandscape
                                    ? constraints.maxWidth * 0.5
                                    : constraints.maxWidth * 1;

                            return isLandscape
                                ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children:
                                        tasks.map((task) {
                                          return ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth: taskCardWidth,
                                            ),
                                            child: GestureDetector(
                                              onLongPress: () {
                                                context
                                                    .read<TaskmanageBloc>()
                                                    .add(
                                                      UpdateTaskStageBloc(
                                                        taskId: task.id,
                                                        status: status.label,
                                                      ),
                                                    );
                                              },
                                              child: LongPressDraggable<
                                                TaskEntity
                                              >(
                                                data: task,
                                                feedback: Material(
                                                  color: Colors.transparent,
                                                  child: TaskCard(
                                                    task: task,
                                                    isDragging: true,
                                                    width: taskCardWidth,
                                                  ),
                                                ),
                                                childWhenDragging: Opacity(
                                                  opacity: 0.4,
                                                  child: TaskCard(
                                                    task: task,
                                                    width: taskCardWidth,
                                                  ),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (_) =>
                                                              DisplayTaskContents(
                                                                task: task,
                                                              ),
                                                    );
                                                  },
                                                  child: TaskCard(
                                                    task: task,
                                                    width: taskCardWidth,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                )
                                : SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children:
                                        tasks.map((task) {
                                          return ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth: taskCardWidth,
                                            ),
                                            child: GestureDetector(
                                              onLongPress: () {
                                                context
                                                    .read<TaskmanageBloc>()
                                                    .add(
                                                      UpdateTaskStageBloc(
                                                        taskId: task.id,
                                                        status: status.label,
                                                      ),
                                                    );
                                              },
                                              child: LongPressDraggable<
                                                TaskEntity
                                              >(
                                                data: task,
                                                feedback: Material(
                                                  color: Colors.transparent,
                                                  child: TaskCard(
                                                    task: task,
                                                    isDragging: true,
                                                    width: taskCardWidth,
                                                  ),
                                                ),
                                                childWhenDragging: Opacity(
                                                  opacity: 0.4,
                                                  child: TaskCard(
                                                    task: task,
                                                    width: taskCardWidth,
                                                  ),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (_) =>
                                                              DisplayTaskContents(
                                                                task: task,
                                                              ),
                                                    );
                                                  },
                                                  child: TaskCard(
                                                    task: task,
                                                    width: taskCardWidth,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                );
                          },
                        ),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
