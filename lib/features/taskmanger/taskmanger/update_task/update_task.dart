import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/utils/loader.dart';
import 'package:taskmanagementapp/core/common/widgets/task_textfield.dart';
import 'package:taskmanagementapp/core/enum/task_enum.dart';
import 'package:taskmanagementapp/features/auth/presentation/widgets/comm_auth_button.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/task_screen/task_screen.dart';

class UpdateTaskScreen extends StatelessWidget {
  final String taskId;
  final String initialTitle;
  final String initialDescription;

  UpdateTaskScreen({
    super.key,
    required this.taskId,
    required this.initialTitle,
    required this.initialDescription,
  });

  final ValueNotifier<TaskStatus> selectedStatus = ValueNotifier<TaskStatus>(
    TaskStatus.pending,
  );

  @override
  Widget build(BuildContext context) {
    final controllerTitle = TextEditingController(text: initialTitle);
    final controllerDescription = TextEditingController(
      text: initialDescription,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Update Task')),
      body: BlocConsumer<TaskmanageBloc, TaskmanageState>(
        listener: (context, state) {
          if (state is TaskStageUpdateState) {
            print("Navigating to TaskScreen...");
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const TaskScreen()),
              );
            });
          }
        },
        builder: (context, state) {
          final isLoading = state is TaskmanageLoading;

          return SizedBox.expand(
            child: Stack(
              children: [
                IgnorePointer(
                  ignoring: isLoading,
                  child: _buildForm(
                    context,
                    controllerTitle,
                    controllerDescription,
                  ),
                ),
                if (isLoading) const LoadingOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    TextEditingController controllerTitle,
    TextEditingController controllerDescription,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          TaskTextField(controller: controllerTitle, label: 'Title'),
          const SizedBox(height: 16),
          TaskTextField(
            controller: controllerDescription,
            label: 'Description',
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<TaskStatus>(
            valueListenable: selectedStatus,
            builder: (context, value, child) {
              return DropdownButtonFormField<TaskStatus>(
                value: value,
                onChanged: (status) {
                  if (status != null) {
                    selectedStatus.value = status;
                  }
                },
                items:
                    TaskStatus.values.map((status) {
                      return DropdownMenuItem<TaskStatus>(
                        value: status,
                        child: Text(status.label),
                      );
                    }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Task Status',
                  border: OutlineInputBorder(),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          CommonAuthButton(
            onPressed: () {
              context.read<TaskmanageBloc>().add(
                UpdateTaskBloc(
                  controllerTitle.text.trim(),
                  controllerDescription.text.trim(),
                  taskId: taskId,
                  status: selectedStatus.value.label,
                ),
              );
            },
            text: 'Update Task',
          ),
        ],
      ),
    );
  }
}
