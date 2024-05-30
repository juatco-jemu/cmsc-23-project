import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/api/api_firebase_donor.dart';
import 'package:donation_system/model/model_donor.dart';
import 'package:flutter/material.dart';

class DonorsProvider with ChangeNotifier {
  FirebaseDonorAPI firebaseService = FirebaseDonorAPI();
  late Stream<QuerySnapshot> _donorStream;
  
  DonorsProvider() {
    fetchDonors();
  }

  Stream<QuerySnapshot> get donor => _donorStream;

  void fetchDonors() {
    _donorStream = firebaseService.getAllDonors();
    notifyListeners();
  }

  Future<Donor?> getDonorByEmail(String email) async {
    return firebaseService.getDonorByEmail(email);
  }
}