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
      String orgDescription,
      List<String> orgAddressList,
      String orgContactNumber,
      List<DonationDrive> orgDriveList,
      String orgStatus,
      String password
    ) async {
    await authService.signUpOrganization(
      orgName,
      orgEmail,
      orgUsername,
      orgDescription,
      orgAddressList,
      orgContactNumber,
      orgDriveList,
      orgStatus,
      password);
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
      String password
    ) async {
    await authService.signUpDonor(
      firstName, 
      lastName, 
      username, 
      email, 
      addressList, 
      contactNumber,
      donationList,
      password);
    notifyListeners();
  }

  Future<void> signIn(
    String username,
    String password
  ) async {
    await authService.signIn(
      username,
      password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
