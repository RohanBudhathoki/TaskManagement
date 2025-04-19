import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanagementapp/core/common/utils/loader.dart';
import 'package:taskmanagementapp/core/common/utils/text_controller.dart';

import 'package:taskmanagementapp/features/taskmanger/taskmanger/add_task/widget/add_task_form.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/task_screen/task_screen.dart';

import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final controller = TextEditingControllers();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(centerTitle: true, title: const Text("Create Task")),
      body: BlocConsumer<TaskmanageBloc, TaskmanageState>(
        listener: (context, state) {
          if (state is TaskmanageSucess) {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (_) => const TaskScreen()),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is TaskmanageLoading;

          return SizedBox.expand(
            child: Stack(
              children: [
                IgnorePointer(
                  ignoring: isLoading,
                  child: buildFormAddTask(context, controller),
                ),
                if (isLoading) const LoadingOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }
}
