import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:to_do/core/utils/app_logger.dart';
import 'package:to_do/data/model/task_model.dart';

import '../model/user_model.dart';
import 'auth_controller.dart';

class FirestoreController extends GetxController {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection(tbUsers);

  static const String tbUsers = 'users';
  static const String tbTask = 'tasks';

  //user operations
  Future createUser(UserModel user) async {
    try {
      await _usersCollectionReference
          .doc(user.userId)
          .set(user.toJson(), SetOptions(merge: true));
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  final usersQuery = FirebaseFirestore.instance
      .collection('users')
      .orderBy('name')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Future deleteCurrentUser(String uid) async {
    try {
      await _usersCollectionReference.doc(uid).delete();
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<FirebaseResult> getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return FirebaseResult(data: UserModel.fromSnapshot(userData));
    } catch (e) {
      AppLogger().error(e);
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message.toString());
      }

      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  //task operations
  Future<FirebaseResult> createTask(TaskModel task, String uid) async {
    try {
      //add task as current user nested collection
      await _usersCollectionReference
          .doc(uid)
          .collection(tbTask)
          .doc(task.id)
          .set(task.toJson(), SetOptions(merge: true));
      return FirebaseResult(data: true);
    } catch (e) {
      AppLogger().warning(e);
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message.toString());
      }

      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> deleteTask(
      {required String taskId, required String uid}) async {
    try {
      //add task as current user nested collection
      await _usersCollectionReference
          .doc(uid)
          .collection(tbTask)
          .doc(taskId)
          .delete();

      return FirebaseResult(data: true);
    } catch (e) {
      AppLogger().warning(e);
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message.toString());
      }

      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> markTaskAsCompleted(
      {required String taskId, required String uid}) async {
    try {
      //add task as current user nested collection
      await _usersCollectionReference
          .doc(uid)
          .collection(tbTask)
          .doc(taskId)
          .update({'status': TaskStatus.done.index});

      return FirebaseResult(data: true);
    } catch (e) {
      AppLogger().warning(e);
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message.toString());
      }

      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> markTaskAsCanceled(
      {required String taskId, required String uid}) async {
    try {
      //add task as current user nested collection
      await _usersCollectionReference
          .doc(uid)
          .collection(tbTask)
          .doc(taskId)
          .update({'status': TaskStatus.canceled.index});

      return FirebaseResult(data: true);
    } catch (e) {
      AppLogger().warning(e);
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message.toString());
      }

      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Stream<List<TaskModel>> streamTasks(String uid) {
    Stream<QuerySnapshot> snap = _usersCollectionReference.doc(uid).collection(tbTask)
        .orderBy('created_at', descending: true)
        .snapshots();

    return snap.map((snapshot) =>
        snapshot.docs.map((doc) => TaskModel.fromSnapshot(doc)).toList());
  }

}
