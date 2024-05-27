import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDonationDrive() {
    return db.collection('donation_drives').snapshots();
  }

  Stream<QuerySnapshot> getDonationDrivesForOrganization(String orgUsername) {
    return db.collection('donation_drives')
      .where('orgUsername', isEqualTo: orgUsername)
      .snapshots();
  }

  Future<String> addDonationDrive(Map<String, dynamic> donationDrive) async {
    try {
      await db.collection('donation_drives').add(donationDrive);
      return "Donation drive added successfully";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> updateDonationDriveStatus(int driveID, String driveStatus) async {
    try {
      QuerySnapshot querySnapshot = await db
        .collection('donation_drives')
        .where('driveID', isEqualTo: driveID)
        .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({
          'driveStatus': driveStatus
        });
      }
      return "Donation drive ID updated successfully";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
  
}
