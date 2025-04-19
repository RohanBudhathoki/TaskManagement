import 'package:flutter/material.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/entities/task_entity.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final bool isDragging;

  const TaskCard({required this.task, this.isDragging = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isDragging ? 6 : 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDragging ? Colors.blueAccent : Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Title: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: isDragging ? Colors.white : Colors.black87,
                    ),
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Description: ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              task.description,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: isDragging ? Colors.white70 : Colors.black54,
              ),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
