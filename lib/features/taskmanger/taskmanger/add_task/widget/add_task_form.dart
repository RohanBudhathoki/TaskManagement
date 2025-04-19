import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/utils/text_controller.dart';
import 'package:taskmanagementapp/core/common/widgets/task_textfield.dart';
import 'package:taskmanagementapp/features/auth/presentation/widgets/comm_auth_button.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';

Widget buildFormAddTask(
  BuildContext context,
  TextEditingControllers controller,
) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 100),
          TaskTextField(controller: controller.titleController, label: 'Title'),
          const SizedBox(height: 16),
          TaskTextField(
            controller: controller.descriptionController,
            label: 'Description',
            maxLines: 3,
          ),
          const SizedBox(height: 25),
          CommonAuthButton(
            onPressed: () {
              context.read<TaskmanageBloc>().add(
                CreateTaskBloc(
                  title: controller.titleController.text.trim(),
                  description: controller.titleController.text.trim(),
                ),
              );
            },
            text: "Create Task",
          ),
        ],
      ),
    ),
  );
}
