import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/enum/task_enum.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';

class UpdateTaskScreen extends StatelessWidget {
  final String taskId;
  final String initialTitle;
  final String initialDescription;

  final TextEditingController controllerTitle;
  final TextEditingController controllerDescription;

  UpdateTaskScreen({
    super.key,
    required this.taskId,
    required this.initialTitle,
    required this.initialDescription,
  }) : controllerTitle = TextEditingController(text: initialTitle),
       controllerDescription = TextEditingController(text: initialDescription);

  final ValueNotifier<TaskStatus> selectedStatus = ValueNotifier<TaskStatus>(
    TaskStatus.pending,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controllerTitle,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controllerDescription,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
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
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
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
                child: const Text('Update Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
