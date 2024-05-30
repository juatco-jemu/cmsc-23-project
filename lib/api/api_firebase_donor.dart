import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/model/model_donor.dart';

class FirebaseDonorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  
  Stream<QuerySnapshot> getAllDonors() {
    return db.collection('donors').snapshots();
  }

  Future<Donor?> getDonorByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await db
        .collection('donors')
        .where('email', isEqualTo: email)
        .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic>? data = querySnapshot.docs.first.data() as Map<String, dynamic>?;
        return Donor.fromJson(data!);
      } else {
        return null;
      }

    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }
}