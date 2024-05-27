import 'package:donation_system/api/api_firebase_auth.dart';
import 'package:donation_system/model/model_donation.dart';
import 'package:donation_system/model/model_drive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> _uStream;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => _uStream;
  User? get user => authService.getUser();

  void fetchAuthentication() {
    _uStream = authService.userSignedIn();

    notifyListeners();
  }

  Future<void> signUpOrganization(
      String orgName,
      String orgEmail,
      String orgUsername,
      List<String> orgAddressList,
      String orgContactNumber,
      List<DonationDrive> orgDriveList,
      String password) async {
    await authService.signUpOrganization(orgName, orgEmail, orgUsername, orgAddressList, orgContactNumber, orgDriveList, password);
    notifyListeners();
  }

  Future<void> signUpDonor(
      String firstName,
      String lastName,
      String username,
      String email,
      List<String> addressList,
      String contactNumber,
      List<Donation> donationList,
      String password) async {
    await authService.signUpDonor(firstName, lastName, username, email, addressList, contactNumber, donationList, password);
    notifyListeners();
  }

  Future<String?> signIn(String email, String password) async {
    String? message = await authService.signIn(email, password);
    print('Current user: ${authService.getUser()}');
    notifyListeners();
    return message;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}