import 'package:camera/camera.dart';
import 'package:donation_system/api/api_firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageProvider with ChangeNotifier {
  FirebaseStorageAPI firebaseService = FirebaseStorageAPI();

  Future<String> addQRImage(XFile imageData, String donationID) async {
    return await firebaseService.addQRImage(imageData, donationID);
  }
}