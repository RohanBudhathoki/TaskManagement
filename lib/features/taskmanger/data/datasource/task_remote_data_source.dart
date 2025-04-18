import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:taskmanagementapp/core/error/exception.dart';
import 'package:taskmanagementapp/features/taskmanger/data/models/task_model.dart';
import 'package:taskmanagementapp/features/taskmanger/domain/usecases/update_task.dart';

abstract interface class TaskRemoteDataSources {
  Future<TaskModel?> create(TaskModel task);
  Stream<List<TaskModel>> getTasks();
  Future<TaskModel?> updateTaskStage({
    required String taskId,
    required String status,
  });
  Future<TaskModel?> updateTask({
    required String taskId,
    required String status,
    required String title,
    required String description,
  });
}

class TaskDataSource implements TaskRemoteDataSources {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  TaskDataSource(this.firestore, this.auth);

  @override
  Future<TaskModel?> create(TaskModel task) async {
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }

    try {
      final taskDoc =
          firestore.collection('users').doc(userId).collection('tasks').doc();

      final taskWithUserId = task.copyWith(userId: userId, id: taskDoc.id);

      await taskDoc.set(taskWithUserId.toMap());

      return taskWithUserId;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TaskModel?> updateTaskStage({
    required String taskId,
    required String status,
  }) async {
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }

    try {
      final docRef = firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId);

      await docRef.update({'status': status});

      final updatedSnapshot = await docRef.get();
      return TaskModel.fromMap(updatedSnapshot.data()!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<List<TaskModel>> getTasks() {
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }

    try {
      final taskStream = firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .snapshots()
          .map((snapshot) {
            print(
              "📦 Snapshot received with ${snapshot.docs.length} documents",
            );

            return snapshot.docs.map((doc) {
              final data = doc.data();
              print("📄 Document data: $data");

              return TaskModel.fromMap(data);
            }).toList();
          });

      taskStream.listen((taskList) {
        print("✅ Stream emitted a task list with ${taskList.length} tasks");
        if (taskList.isNotEmpty) {
          print("🧾 First Task: ${taskList.first}");
        }
      });

      return taskStream;
    } catch (e) {
      throw ServerException('Error fetching tasks: ${e.toString()}');
    }
  }

  @override
  Future<TaskModel?> updateTask({
    required String taskId,
    required String status,
    required String title,
    required String description,
  }) async {
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }

    try {
      final docRef = firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId);

      await docRef.update({
        'status': status,
        'title': title,
        'description': description,
      });

      final updatedSnapshot = await docRef.get();

      if (!updatedSnapshot.exists) {
        throw const ServerException('Task not found');
      }

      return TaskModel.fromMap(updatedSnapshot.data()!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
