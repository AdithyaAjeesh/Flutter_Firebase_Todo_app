// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_app/model/todo_model.dart';
import 'package:flutter_firebase_todo_app/view/home_screen.dart';

class FunctionsController extends ChangeNotifier {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('todo');

  TextEditingController nameController = TextEditingController();
  TextEditingController subNameController = TextEditingController();

  Future<TodoModel> postData(BuildContext context) async {
    TodoModel todoModel = TodoModel(
      name: nameController.text,
      subName: subNameController.text,
      isDone: false,
    );
    try {
      DocumentReference docRef = collection.doc();
      todoModel.id = docRef.id;
      await docRef.set(todoModel.toJson());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
      return todoModel;
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }

  Stream<List<TodoModel>> getAllData() {
    return collection.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) =>
                  TodoModel.fromJson(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  Future<void> deleteData(docId) async {
    return collection.doc(docId).delete();
  }

  Future<void> updateData(docId, isDone) async {
    TodoModel todoModel = TodoModel(
      name: nameController.text,
      subName: subNameController.text,
      id: docId,
      isDone: isDone,
    );
    try {
      return await collection.doc(docId).update(todoModel.toJson());
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }

  Future<void> toggleCompleate(docId, isDone, name, subName) async {
    if (isDone == true) {
      isDone = false;
    } else if (isDone == false) {
      isDone = true;
    }
    TodoModel todoModel = TodoModel(
      name: name,
      subName: subName,
      id: docId,
      isDone: isDone,
    );
    try {
      return await collection.doc(docId).update(todoModel.toJson());
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }
}
