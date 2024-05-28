import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/api/api_firebase_org.dart';
import 'package:donation_system/model/model_organization.dart';
import 'package:flutter/material.dart';

class OrganizationsProvider with ChangeNotifier {
  FirebaseOrganizationAPI firebaseService = FirebaseOrganizationAPI();
  late Stream<QuerySnapshot> _organizationStream;

  OrganizationsProvider() {
    fetchOrganization();
  }

  Stream<QuerySnapshot> get organization => _organizationStream;

  void fetchOrganization() {
    _organizationStream = firebaseService.getAllOrganizations();
    notifyListeners();
  }

  Future<Organization?> getOrganizationByUsername(String orgUsername) async {
    return firebaseService.getOrganizationByUsername(orgUsername);
  }

  Future<void> updateOrganizationStatus(String orgUsername, String orgStatus) async {
    await firebaseService.updateOrganizationStatus(orgUsername, orgStatus);
    notifyListeners();
  }

  Future<String?> getOrganizationStatus(String orgUsername) async {
    return firebaseService.getOrganizationStatus(orgUsername);
  }

  Future<String?> getOrganizationUsername(String orgEmail) async {
    return firebaseService.getOrganizationUsername(orgEmail);
  }

}
