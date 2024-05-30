import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  // int? donationID;
  String? donorUsername;
  String? orgUsername;
  List<String>? itemsToDonate;
  int? weight;
  String? mode; // Pickup or Drop-off
  DateTime? dateTime;
  List<String>? addresses;
  String? contactNumber;
  String? imageURL; // Image as proof
  String? qrCode; // QR Code for Drop-off
  String? status; // Pending, Confirmed, Scheduled for Pick-up, Completed, Canceled

  Donation({
    // required this.donationID,
    required this.donorUsername,
    required this.orgUsername,
    required this.itemsToDonate,
    required this.weight,
    required this.mode,
    required this.dateTime,
    required this.addresses,
    required this.contactNumber,
    required this.imageURL,
    required this.qrCode,
    required this.status,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      // donationID: json['donationID'],
      donorUsername: json['donorUsername'],
      orgUsername: json['orgUsername'],
      itemsToDonate: List<String>.from(json['itemsToDonate']),
      weight: json['weight'],
      mode: json['mode'],
      dateTime: (json['dateTime'] as Timestamp).toDate(), // Convert Timestamp to DateTime
      addresses: List<String>.from(json['addresses']),
      contactNumber: json['contactNumber'],
      imageURL: json['imageURL'],
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
      // 'donationID': donationID,
      'donorUsername': donorUsername,
      'orgUsername': orgUsername,
      'itemsToDonate': itemsToDonate,
      'weight': weight,
      'mode': mode,
      'dateTime': Timestamp.fromDate(dateTime!), // Convert DateTime to Timestamp
      'addresses': addresses,
      'contactNumber': contactNumber,
      'imageURL': imageURL,
      'qrCode': qrCode,
      'status': status,
    };
  }
}
