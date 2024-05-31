import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/api/api_firebase_donor.dart';
import 'package:donation_system/api/api_firebase_gen_functions.dart';
import 'package:donation_system/model/model_donor.dart';
import 'package:flutter/material.dart';

class DonorsProvider with ChangeNotifier {
  FirebaseDonorAPI firebaseService = FirebaseDonorAPI();
  FirebaseFunctionsAPI firebaseFunctions = FirebaseFunctionsAPI();
  late Stream<QuerySnapshot> _donorStream;
  late Donor? _donorData;
  late Stream<DocumentSnapshot> _donorDataStream;

  DonorsProvider() {
    fetchDonors();
    _donorData = Donor(
        firstName: "",
        lastName: "",
        email: "",
        username: "",
        addressList: [],
        contactNumber: "",
        donationIDList: []);
  }

  Stream<QuerySnapshot> get donor => _donorStream;
  Donor? get donorData => _donorData;
  Stream<DocumentSnapshot> get donorDataStream => _donorDataStream;

  void fetchDonors() {
    _donorStream = firebaseService.getAllDonors();
    notifyListeners();
  }

  void fetchDonorData() {
    _donorDataStream = firebaseFunctions.getUserData("donors");
    notifyListeners();
  }

  void getDonorByEmail(String email) async {
    _donorData = await firebaseService.getDonorByEmail(email);
    notifyListeners();
  }

  // void editAddress(String id, String newTitle) async {
  //   await firebaseService.editAddress(id, newTitle);
  //   notifyListeners();
  // }

  // void deleteAddress(String id) async {
  //   await firebaseService.deleteAddress(id);
  //   notifyListeners();
  // }
}
