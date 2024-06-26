import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<int> getNextDonationID() async {
    try {
      QuerySnapshot querySnapshot = await db
        .collection('donations')
        .orderBy('donationID', descending: true)
        .limit(1)
        .get();

      if (querySnapshot.docs.isNotEmpty) {
        int latestDonationID = querySnapshot.docs.first.get('donationID');
        return latestDonationID + 1;
      } else {
        return 1; // Default to 1 if no drives exist
      }
    } on FirebaseException catch (e) {
      print("Error in ${e.code}: ${e.message}");
      return 1; // Default to 1 in case of an error
    }
  }

  Stream<QuerySnapshot> getAllDonation() {
    return db.collection('donation').snapshots();
  }

  Stream<QuerySnapshot> getDonationForDonor(String username) {
    return db.collection('donations')
      .where('donorUsername', isEqualTo: username)
      .snapshots();
  }

  Stream<QuerySnapshot> getDonationForOrganization(String username) {
    return db.collection('donations')
      .where('orgUsername', isEqualTo: username)
      .snapshots();
  }

  Future<String> addDonation(Map<String, dynamic> donation) async {
    try {
      await db.collection('donations').add(donation);
      return "Donation added successfully";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}