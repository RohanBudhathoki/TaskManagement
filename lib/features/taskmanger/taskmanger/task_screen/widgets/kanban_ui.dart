import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/widgets/task_card.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';
import 'package:taskmanagementapp/core/enum/task_enum.dart';

class KanbanBoard extends StatelessWidget {
  const KanbanBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<TaskmanageBloc>()..add(GetTaskBLoc()),
      child: Scaffold(
        appBar: AppBar(title: Text('Kanban Board')),
        body: BlocBuilder<TaskmanageBloc, TaskmanageState>(
          builder: (context, state) {
            if (state is TaskmanageLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is TaskmanageFailure) {
              return Center(child: Text(state.message));
            }
            if (state is TaskManageDisplaySucess) {
              var tasksByStatus = _groupTasksByStatus(state.task);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      TaskStatus.values.map((status) {
                        return Expanded(
                          child: StatusColumn(
                            status: status,
                            tasks: tasksByStatus[status] ?? [],
                          ),
                        );
                      }).toList(),
                ),
              );
            }
            return Center(child: Text("No tasks available"));
          },
        ),
      ),
    );
  }

  Map<TaskStatus, List<TaskEntity>> _groupTasksByStatus(
    List<TaskEntity> tasks,
  ) {
    Map<TaskStatus, List<TaskEntity>> tasksByStatus = {
      TaskStatus.pending: [],
      TaskStatus.ongoing: [],
      TaskStatus.testing: [],
      TaskStatus.completed: [],
    };

    for (var task in tasks) {
      tasksByStatus[task.status]?.add(task);
    }

    return tasksByStatus;
  }
}

class StatusColumn extends StatelessWidget {
  final TaskStatus status;
  final List<TaskEntity> tasks;

  const StatusColumn({required this.status, required this.tasks, super.key});

  @override
  Widget build(BuildContext context) {
    return DragTarget<TaskEntity>(
      onAccept: (task) {
        context.read<TaskmanageBloc>().add(
          UpdateTaskStageBloc(taskId: task.id, status: status.label),
        );
      },
      builder: (context, candidateData, rejectedData) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status.label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                tasks.isEmpty
                    ? const Center(child: Text("No tasks"))
                    : Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return TaskCard(task: tasks[index]);
                        },
                      ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
