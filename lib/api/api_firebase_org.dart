import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrganizationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // Gets all the organization from Firestore
  Stream<QuerySnapshot> getAllOrganizations() {
    return db.collection('organizations').snapshots();
  }

  Future<void> updateOrganizationStatus(String orgUsername, String orgStatus) async {
    try {
      QuerySnapshot querySnapshot = await db
        .collection('organizations')
        .where('orgUsername', isEqualTo: orgUsername)
        .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({
          'orgStatus': orgStatus
        });
      }
      return;
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
