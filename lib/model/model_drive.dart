import 'dart:convert';
import 'package:donation_system/model/model_donation.dart';

class DonationDrive {
  String? driveName;
  String? driveStatus; // Open or Closed
  String? driveDescription;
  String? driveLocation;
  List<String>? driveImgURL;
  List<Donation>? driveDonationList;

  DonationDrive({
    required this.driveName,
    required this.driveStatus,
    required this.driveDescription,
    required this.driveLocation,
    required this.driveImgURL,
    required this.driveDonationList,
  });

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      driveName: json['driveName'],
      driveStatus: json['driveStatus'],
      driveDescription: json['driveDescription'],
      driveLocation: json['driveLocation'],
      driveImgURL: List<String>.from(json['driveImgURL']),
      driveDonationList: (json['driveDonationList'] as List<dynamic>)
          .map((donation) => Donation.fromJson(donation))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driveName': driveName,
      'driveStatus': driveStatus,
      'driveDescription': driveDescription,
      'driveLocation': driveLocation,
      'driveImgURL': driveImgURL,
      'driveDonationList': driveDonationList?.map((donation) => donation.toJson()).toList(),
    };
  }

  static List<DonationDrive> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<DonationDrive>((dynamic json) => DonationDrive.fromJson(json)).toList();
  }
}
