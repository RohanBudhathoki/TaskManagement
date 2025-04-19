import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/enum/task_enum.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/add_task/add_task_screen.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/task_screen/widgets/status_row.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<TaskmanageBloc>()..add(GetTaskBLoc()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task Manager'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddTaskScreen()),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<TaskmanageBloc, TaskmanageState>(
          listener: (context, state) {
            if (state is TaskmanageFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is TaskmanageSucess) {
              context.read<TaskmanageBloc>().add(GetTaskBLoc());
            }
          },
          builder: (context, state) {
            if (state is TaskmanageLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TaskManageDisplaySucess) {
              final tasks = state.task;

              return Column(
                children:
                    TaskStatus.values.map((status) {
                      final tasksForStatus =
                          tasks
                              .where((task) => task.status == status.label)
                              .toList();
                      return StatusRow(status: status, tasks: tasksForStatus);
                    }).toList(),
              );
            }

            return const Center(child: Text('Unable to load tasks.'));
          },
        ),
      ),
    );
  }
}
