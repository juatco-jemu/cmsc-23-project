import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonorsProvider with ChangeNotifier {
  late Stream<QuerySnapshot> _donorStream;
  
  DonorsProvider() {
    fetchDonors();
  }

  Stream<QuerySnapshot> get donor => _donorStream;

  void fetchDonors() {
    _donorStream = FirebaseFirestore.instance.collection('donors').snapshots();
    notifyListeners();
  }
}