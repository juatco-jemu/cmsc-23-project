import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/firebase_auth_api.dart';
import '../model/model_user.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<Users?> _uStream;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<Users?> get userStream => _uStream;
  User? get user => authService.getUser();

  void fetchAuthentication() {
    _uStream = authService.userSignedIn() as Stream<Users?>;

    notifyListeners();
  }

  Future<void> signUp(String firstName, String lastName, String email, String password) async {
    await authService.signUp(firstName, lastName, email, password);
    notifyListeners();
  }

  Future<String?> signIn(String email, String password) async {
    String? message = await authService.signIn(email, password);
    notifyListeners();

    return message;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
