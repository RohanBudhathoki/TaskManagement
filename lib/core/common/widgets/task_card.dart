import 'package:flutter/material.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;

  const TaskCard({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable<TaskEntity>(
      data: task,
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.blue,
          child: Text(task.title, style: const TextStyle(color: Colors.white)),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.4,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(task.title),
          ),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(task.title),
        ),
      ),
    );
  }
}
