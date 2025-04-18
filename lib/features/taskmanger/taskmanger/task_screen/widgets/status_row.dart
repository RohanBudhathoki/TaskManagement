import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/widgets/task_card.dart';
import 'package:taskmanagementapp/core/theme/app_colors.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';
import 'package:taskmanagementapp/core/enum/task_enum.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/update_task/update_task.dart';

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
              padding: const EdgeInsets.all(8.0),
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
                      ? const Center(child: Text("No tasks"))
                      : SizedBox(
                        height: 100.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Draggable<TaskEntity>(
                                data: tasks[index],
                                feedback: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.blue,
                                    child: Text(
                                      tasks[index].title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                childWhenDragging: Opacity(
                                  opacity: 1,
                                  child: TaskCard(task: tasks[index]),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => UpdateTaskScreen(
                                              taskId: tasks[index].id,
                                              initialTitle: tasks[index].title,
                                              initialDescription:
                                                  tasks[index].description,
                                            ),
                                      ),
                                    );
                                  },
                                  child: TaskCard(task: tasks[index]),
                                ),
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
