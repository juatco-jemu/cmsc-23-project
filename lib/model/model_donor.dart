import 'dart:convert';
import 'package:donation_system/model/model_donation.dart';

class Donor {
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  List<String>? addressList;
  String? contactNumber;
  List<Donation>? donationList;

  Donor({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.addressList,
    required this.contactNumber,
    this.donationList,
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      username: json['username'],
      addressList: List<String>.from(json['addresses']),
      contactNumber: json['contactNumber'],
      donationList: json['donationList'] != null
          ? (json['donationList'] as List)
              .map((i) => Donation.fromJson(i))
              .toList()
          : [],
    );
  }

  static List<Donor> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donor>((dynamic d) => Donor.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'addressList': addressList,
      'contactNumber': contactNumber,
      'donationList': donationList?.map((d) => d.toJson()).toList(),
    };
  }
}
