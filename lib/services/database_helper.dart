import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_revision/utils/utils.dart';
import 'package:firebase_revision/views/pages/add_task_page.dart';
import 'package:flutter/cupertino.dart';

class DataBaseHelper {
  String? userEmail = FirebaseAuth.instance.currentUser == null
      ? "UndefinedEmail"
      : FirebaseAuth.instance.currentUser!.email;
  String? userName = FirebaseAuth.instance.currentUser!.displayName;

  Future<void> AddTask(
      String taskName, String details, String date, BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection(userEmail ?? "users");
    return users.doc("data").collection("tasks").add({
      'task_name': taskName.trim(),
      'details': details.trim(),
      'date': date,
      'isCompleted': false
    }).then((value) {
      Utils().snackBar(context, "Task Added");
      Navigator.of(context).pop();
    }).catchError((error) => Utils().snackBar(context, "Failed to add Task."));
  }

  Future<void> addUser(
      String name, String email, DateTime date, BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(email);
    return users.doc("profile").set({
      'name': name.trim(),
      'email': email.trim(),
      'joining_date': date
    }).then((value) {
      print("User Added");
      Navigator.of(context).pop();
    }).catchError((error) => print("Failed to add User."));
  }
}
