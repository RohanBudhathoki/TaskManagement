import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/utils/flush_bar.dart';
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
              final title = controller.titleController.text.trim();
              final description = controller.descriptionController.text.trim();

              if (title.isEmpty || description.isEmpty) {
                flushBar(
                  context,
                  "Please fill in both the title and description.",
                );
                return;
              }

              context.read<TaskmanageBloc>().add(
                CreateTaskBloc(title: title, description: description),
              );
            },
            text: "Create Task",
          ),
        ],
      ),
    ),
  );
}
