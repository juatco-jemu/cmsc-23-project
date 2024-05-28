import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/api/api_firebase_drive.dart';
import 'package:donation_system/model/model_drive.dart';
import 'package:flutter/foundation.dart';

class DonationDriveProvider with ChangeNotifier {
  FirebaseDriveAPI firebaseService = FirebaseDriveAPI();
  late Stream<QuerySnapshot> _donationdriveStream;

  DonationDriveProvider() {
    fetchDonationDrives();
  }

  Stream<QuerySnapshot> get donationDrive => _donationdriveStream;

  void fetchDonationDrives() {
    _donationdriveStream = firebaseService.getAllDonationDrive();
    notifyListeners();
  }

  Future<int> getNextDriveID() async {
  return await firebaseService.getNextDriveID();
}

  Stream<QuerySnapshot> getDonationDrivesForOrganization(String orgUsername) {
    return firebaseService.getDonationDrivesForOrganization(orgUsername);
  }

  void addDonationDrive(DonationDrive donationDrive) async {
    String message = await firebaseService.addDonationDrive(donationDrive.toJson(donationDrive));
    print(message);
    notifyListeners();
  }

  void updateDonationDriveStatus(int driveID, String driveStatus) async {
    String message = await firebaseService.updateDonationDriveStatus(driveID, driveStatus);
    print(message);
    notifyListeners();
  }
}