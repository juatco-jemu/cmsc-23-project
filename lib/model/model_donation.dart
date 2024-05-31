import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  int donationID;
  int driveID;
  String donorUsername;
  String orgUsername;
  List<String> itemsToDonate;
  String weight;
  String mode; // Pickup or Drop-off
  DateTime dateTime;
  String selectedAddress;
  String contactNumber;
  List<String> imageURL; // Image as proof
  String qrCode; // QR Code for Drop-off
  String status; // Pending, Confirmed, Scheduled for Pick-up, Completed, Canceled

  Donation({
    required this.donationID,
    required this.driveID,
    required this.donorUsername,
    required this.orgUsername,
    required this.itemsToDonate,
    required this.weight,
    required this.mode,
    required this.dateTime,
    required this.selectedAddress,
    required this.contactNumber,
    required this.imageURL,
    required this.qrCode,
    required this.status,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      donationID: json['donationID'],
      driveID: json['driveID'],
      donorUsername: json['donorUsername'],
      orgUsername: json['orgUsername'],
      itemsToDonate: List<String>.from(json['itemsToDonate']),
      weight: json['weight'],
      mode: json['mode'],
      dateTime: (json['dateTime'] as Timestamp).toDate(), // Convert Timestamp to DateTime
      selectedAddress: json['selectedAddress'],
      contactNumber: json['contactNumber'],
      imageURL: List<String>.from(json['imageURL']),
      qrCode: json['qrCode'],
      status: json['status'],
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      'donationID': donation.donationID,
      'driveID': donation.driveID,
      'donorUsername': donation.donorUsername,
      'orgUsername': donation.orgUsername,
      'itemsToDonate': donation.itemsToDonate,
      'weight': donation.weight,
      'mode': donation.mode,
      'dateTime': Timestamp.fromDate(donation.dateTime!), // Convert DateTime to Timestamp
      'selectedAddress': donation.selectedAddress,
      'contactNumber': donation.contactNumber,
      'imageURL': donation.imageURL,
      'qrCode': donation.qrCode,
      'status': donation.status,
    };
  }
}
