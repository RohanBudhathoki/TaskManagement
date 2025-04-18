class TaskEntity {
  final String id;
  final String title;
  final String description;
  final String status;
  final String userId;

  TaskEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });
}
