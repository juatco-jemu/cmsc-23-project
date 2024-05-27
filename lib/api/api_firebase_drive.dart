import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/model/model_donation.dart';

class FirebaseDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDonationDrive(
    int? driveID,
    String? orgUsername,
    String driveName,
    String driveStatus,
    String driveDescription,
    String driveLocation,
    List<String> driveImgURL,
    List<Donation> driveDonationList,
  ) async {
    try {
      await db.collection('donation_drives').add({
        'driveID': driveID,
        'orgUsername': orgUsername,
        'driveName': driveName,
        'driveStatus': driveStatus,
        'driveDescription': driveDescription,
        'driveLocation': driveLocation,
        'driveImgURL': driveImgURL,
        'driveDonationList': driveDonationList.map((donation) => donation.toJson()).toList(),
      });
      return "Donation drive added successfully";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllDonationDrive() {
    return db.collection('donation_drives').snapshots();
  }
}
