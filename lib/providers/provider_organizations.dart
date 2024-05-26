import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrganizationsProvider with ChangeNotifier {
  late Stream<QuerySnapshot> _organizationStream;
  
  OrganizationsProvider() {
    fetchOrganization();
  }

  Stream<QuerySnapshot> get donor => _organizationStream;

  void fetchOrganization() {
    _organizationStream = FirebaseFirestore.instance.collection('organizations').snapshots();
    notifyListeners();
  }
}