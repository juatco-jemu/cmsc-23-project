import 'dart:convert';

class Organization {
  String? orgName;
  String? orgEmail;
  String? orgUsername;
  String? orgDescription;
  List<String>? orgAddressList;
  String? orgContactNumber;
  List<int>? orgDriveIDList; 
  String? orgProofImgLink;
  String? orgStatus;  // Pending, Approved, Declined

  Organization({
    required this.orgName,
    required this.orgEmail,
    required this.orgUsername,
    required this.orgDescription,
    required this.orgAddressList,
    required this.orgContactNumber,
    required this.orgDriveIDList, 
    required this.orgProofImgLink,
    required this.orgStatus,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      orgName: json['orgName'],
      orgEmail: json['orgEmail'],
      orgUsername: json['orgUsername'],
      orgDescription: json['orgDescription'],
      orgAddressList: List<String>.from(json['orgAddressList']),
      orgContactNumber: json['orgContactNumber'],
      orgDriveIDList: List<int>.from(json['orgDriveIDList']),
      orgProofImgLink: json['orgProofImgLink'],
      orgStatus: json['orgStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orgName': orgName,
      'orgEmail': orgEmail,
      'orgUsername': orgUsername,
      'orgDescription': orgDescription,
      'orgAddressList': orgAddressList,
      'orgContactNumber': orgContactNumber,
      'orgDriveIDList': orgDriveIDList,
      'orgProofImgLink': orgProofImgLink,
      'orgStatus': orgStatus,
    };
  }

  static List<Organization> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Organization>((dynamic json) => Organization.fromJson(json)).toList();
  }
}
