import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/firebase_admin_api.dart';

class AdminProvider with ChangeNotifier {
  FirebaseTodoAPI firebaseService = FirebaseTodoAPI();
  late Stream<QuerySnapshot> _donorsStream;

  AdminProvider() {
    fetchTodos();
  }
  // getter
  Stream<QuerySnapshot> get donors => _donorsStream;

  void fetchTodos() {
    _donorsStream = firebaseService.getAllDonors();
    notifyListeners();
  }

  // void addTodo(Todo item) async {
  //   String message = await firebaseService.addTodo(item.toJson(item));
  //   print(message);
  //   notifyListeners();
  // }

  // void editTodo(String id, String newTitle) async {
  //   await firebaseService.editTodo(id, newTitle);
  //   notifyListeners();
  // }

  // void deleteTodo(String id) async {
  //   await firebaseService.deleteTodo(id);
  //   notifyListeners();
  // }

  // void toggleStatus(String id, bool status) async {
  //   await firebaseService.toggleStatus(id, status);
  //   notifyListeners();
  // }
}
