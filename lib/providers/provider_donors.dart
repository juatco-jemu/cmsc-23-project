import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/api/api_firebase_donor.dart';
import 'package:donation_system/model/model_donor.dart';
import 'package:flutter/material.dart';

class DonorsProvider with ChangeNotifier {
  FirebaseDonorAPI firebaseService = FirebaseDonorAPI();
  late Stream<QuerySnapshot> _donorStream;
  late Donor? _donorData;

  DonorsProvider() {
    fetchDonors();
  }

  Stream<QuerySnapshot> get donor => _donorStream;
  Donor? get donorData => _donorData;

  void fetchDonors() {
    _donorStream = firebaseService.getAllDonors();
    notifyListeners();
  }

  void getDonorByEmail(String email) async {
    _donorData = await firebaseService.getDonorByEmail(email);
    notifyListeners();
  }
}
