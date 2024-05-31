import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/api/api_firebase_donation.dart';
import 'package:donation_system/model/model_donation.dart';
import 'package:flutter/foundation.dart';

class DonationsProvider with ChangeNotifier {
  FirebaseDonationAPI firebaseService = FirebaseDonationAPI();
  late Stream<QuerySnapshot> _donationStream;

  DonationsProvider() {
    fetchDonations();
  }

  Stream<QuerySnapshot> get donation => _donationStream;

  void fetchDonations() {
    _donationStream = firebaseService.getAllDonation();
    notifyListeners();
  }

  Future<int> getNextDonationID() async {
    return await firebaseService.getNextDonationID();
  }

  Stream<QuerySnapshot> getDonationForDonor(String username) {
    return firebaseService.getDonationForDonor(username);
  }

  Stream<QuerySnapshot> getDonationForOrganization(String username) {
    return firebaseService.getDonationForOrganization(username);
  }

  void addDonation(Donation donation) async {
    String message = await firebaseService.addDonation(donation.toJson(donation));
    print(message);
    notifyListeners();
  }
}