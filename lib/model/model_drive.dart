import 'dart:convert';

class DonationDrive {
  int driveID;
  String orgUsername;
  String driveName;
  String driveStatus; // Open or Closed
  String driveDescription;
  String driveLocation;
  List<String> driveImgURL;
  List<int> driveDonationIDList;

  DonationDrive({
    required this.driveID,
    required this.orgUsername,
    required this.driveName,
    required this.driveStatus,
    required this.driveDescription,
    required this.driveLocation,
    required this.driveImgURL,
    required this.driveDonationIDList,
  });

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      driveID: json['driveID'],
      orgUsername: json['orgUsername'],
      driveName: json['driveName'],
      driveStatus: json['driveStatus'],
      driveDescription: json['driveDescription'],
      driveLocation: json['driveLocation'],
      driveImgURL: List<String>.from(json['driveImgURL']),
      driveDonationIDList: List<int>.from(json['driveDonationIDList']),
    );
  }

  Map<String, dynamic> toJson(DonationDrive donationDrive) {
    return {
      'driveID': donationDrive.driveID,
      'orgUsername': donationDrive.orgUsername,
      'driveName': donationDrive.driveName,
      'driveStatus': donationDrive.driveStatus,
      'driveDescription': donationDrive.driveDescription,
      'driveLocation': donationDrive.driveLocation,
      'driveImgURL': donationDrive.driveImgURL,
      'driveDonationIDList': donationDrive.driveDonationIDList,
    };
  }

  static List<DonationDrive> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<DonationDrive>((dynamic json) => DonationDrive.fromJson(json)).toList();
  }
}
