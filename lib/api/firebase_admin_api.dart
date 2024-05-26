import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseTodoAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseAuth auth =
      FirebaseAuth.instance; // added this to be able to access current user

  // Important: all functions below were modified to include the current user's id
  // changed the database path to users/{currentUserId}/todos
  // this way, each user will have their own list of todos
  // the method used was sub collection

  Future<String> addTodo(Map<String, dynamic> todo) async {
    try {
      await db.collection("users").doc(auth.currentUser!.uid).collection("todos").add(todo);

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllDonors() {
    return db.collection("donors").doc(auth.currentUser!.uid).collection("donors").snapshots();
  }

  Future<String> deleteTodo(String id) async {
    try {
      await db.collection("users").doc(auth.currentUser!.uid).collection("todos").doc(id).delete();

      return "Successfully deleted!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> editTodo(String id, String title) async {
    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("todos")
          .doc(id)
          .update({"title": title});

      return "Successfully edited!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> toggleStatus(String id, bool value) async {
    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("todos")
          .doc(id)
          .update({"completed": value});

      return "Successfully toggled!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}
