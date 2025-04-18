import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:taskmanagementapp/core/error/exception.dart';
import 'package:taskmanagementapp/features/taskmanger/data/models/task_model.dart';

abstract interface class TaskRemoteDataSources {
  Future<TaskModel?> create(TaskModel task);
  Stream<List<TaskModel>> getTasks();
  Future<TaskModel?> updateTaskStage({
    required String taskId,
    required String status,
  });
}

class TaskDataSource implements TaskRemoteDataSources {
  final FirebaseFirestore firestore;

  TaskDataSource(this.firestore);
  @override
  Future<TaskModel?> create(TaskModel task) async {
    try {
      final tasData = firestore.collection('Tasks').doc();

      final taskid = task.copyWith(id: tasData.id);
      await tasData.set(taskid.toMap());
      return taskid;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<List<TaskModel>> getTask() async {
  //   try {
  //     final snapshot = await firestore.collection('Tasks').get();

  //     final tasks =
  //         snapshot.docs.map((doc) {
  //           final data = doc.data();
  //           return TaskModel.fromMap(data);
  //         }).toList();

  //     return tasks;
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }

  @override
  Future<TaskModel?> updateTaskStage({
    required String taskId,
    required String status,
  }) async {
    try {
      final docRef = firestore.collection('Tasks').doc(taskId);
      await docRef.update({'status': status});
      final updatedSnapshot = await docRef.get();
      return TaskModel.fromMap(updatedSnapshot.data()!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<List<TaskModel>> getTasks() {
    try {
      debugger();
      final docref = firestore.collection('Tasks').snapshots().map((snapshot) {
        print("📦 Snapshot received with ${snapshot.docs.length} documents");

        return snapshot.docs.map((doc) {
          final data = doc.data();
          print("📄 Document data: $data");

          return TaskModel.fromMap(data);
        }).toList();
      });

      docref.listen((taskList) {
        print("✅ Stream emitted a task list with ${taskList.length} tasks");
        if (taskList.isNotEmpty) {
          print("🧾 First Task: ${taskList.first}");
        }
      });
      return docref;
    } catch (e) {
      throw ServerException('Error fetching tasks: ${e.toString()}');
    }
  }
}
