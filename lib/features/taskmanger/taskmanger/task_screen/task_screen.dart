import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/enum/task_enum.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/add_task/add_task_screen.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<TaskmanageBloc>()..add(GetTaskBLoc()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('HomeScreen'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddTaskScreen()),
                );
              },
              icon: Icon(Icons.add),
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
              return Center(child: CircularProgressIndicator());
            }

            if (state is TaskManageDisplaySucess) {
              return ListView.builder(
                itemCount: state.task.length,
                itemBuilder: (context, index) {
                  final task = state.task[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text("Status: ${task.status}"),
                          SizedBox(height: 8),
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: TaskStatus.values.length,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<TaskmanageBloc>().add(
                                        UpdateTaskStageBloc(
                                          taskId: task.id,
                                          status:
                                              TaskStatus.values[index].label,
                                        ),
                                      );
                                    },
                                    child: Text(TaskStatus.values[index].label),
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
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
