enum TaskStatus { completed, pending, ongoing, testing }

extension TaskStatusExtension on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.ongoing:
        return 'Running';
      case TaskStatus.testing:
        return 'Testing';
      case TaskStatus.completed:
        return 'Completed';
    }
  }
}
