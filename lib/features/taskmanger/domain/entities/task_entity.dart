import 'package:taskmanagementapp/core/enum/task_enum.dart';

class TaskEntity {
  final String id;
  final String title;
  final String description;
  final String status;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });
}
