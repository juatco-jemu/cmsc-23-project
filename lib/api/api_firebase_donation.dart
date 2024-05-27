import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDonation(
    String? donorUsername,
    String? orgUsername,
    List<String>? itemsToDonate,
    int? weight,
    String? mode,
    DateTime? dateTime,
    List<String>? addresses,
    String? contactNumber,
    String? imageURL,
    String? qrCode,
    String? status,
  ) async {
    try {
      await db.collection('donations').add({
        'donorUsername': donorUsername,
        'orgUsername': orgUsername,
        'itemsToDonate': itemsToDonate,
        'weight': weight,
        'mode': mode,
        'dateTime': dateTime,
        'addresses': addresses,
        'contactNumber': contactNumber,
        'imageURL': imageURL,
        'qrCode': qrCode,
        'status': status,
      });
      return "Donation added successfully";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}
