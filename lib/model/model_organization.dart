import 'dart:convert';
import 'package:donation_system/model/model_drive.dart';

class Organization {
  String? orgName;
  String? orgEmail;
  String? orgUsername;
  List<String>? orgAddressList;
  String? orgContactNumber;
  List<DonationDrive>? orgDriveList;
  String? orgProofImgLink;
  String? orgStatus;  // Pending, Approved, Declined

  Organization({
    required this.orgName,
    required this.orgEmail,
    required this.orgUsername,
    required this.orgAddressList,
    required this.orgContactNumber,
    required this.orgDriveList,
    required this.orgProofImgLink,
    required this.orgStatus,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      orgName: json['orgName'],
      orgEmail: json['orgEmail'],
      orgUsername: json['orgUsername'],
      orgAddressList: List<String>.from(json['orgAddressList']),
      orgContactNumber: json['orgContactNumber'],
      orgDriveList: (json['orgDriveList'] as List<dynamic>)
          .map((drive) => DonationDrive.fromJson(drive))
          .toList(),
      orgProofImgLink: json['orgProofImgLink'],
      orgStatus: json['orgStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orgName': orgName,
      'orgEmail': orgEmail,
      'orgUsername': orgUsername,
      'orgAddressList': orgAddressList,
      'orgContactNumber': orgContactNumber,
      'orgDriveList': orgDriveList?.map((drive) => drive.toJson()).toList(),
      'orgProofImgLink': orgProofImgLink,
      'orgStatus': orgStatus,
    };
  }

  static List<Organization> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Organization>((dynamic json) => Organization.fromJson(json)).toList();
  }
}
