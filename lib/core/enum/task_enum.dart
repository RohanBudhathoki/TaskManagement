import 'package:flutter/material.dart';

enum TaskStatus { completed, pending, ongoing, testing }

extension TaskStatusExtension on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.ongoing:
        return 'Ongoing';
      case TaskStatus.testing:
        return 'Testing';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  Color get cardColor {
    switch (this) {
      case TaskStatus.pending:
        return Colors.amber.shade300;
      case TaskStatus.ongoing:
        return Colors.blue.shade300;
      case TaskStatus.testing:
        return Colors.purple.shade300;
      case TaskStatus.completed:
        return Colors.green.shade300;
    }
  }

  Color get textColor {
    switch (this) {
      case TaskStatus.pending:
        return Colors.brown.shade800;
      case TaskStatus.ongoing:
        return Colors.white;
      case TaskStatus.testing:
        return Colors.white;
      case TaskStatus.completed:
        return Colors.black87;
    }
  }
}
