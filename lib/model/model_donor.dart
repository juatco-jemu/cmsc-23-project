import 'dart:convert';

class Donor {
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  List<String>? addressList;
  String? contactNumber;
  List<int>? donationIDList; 

  Donor({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.addressList,
    required this.contactNumber,
    this.donationIDList, 
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      username: json['username'],
      addressList: List<String>.from(json['addressList']), // Changed to 'addressList'
      contactNumber: json['contactNumber'],
      donationIDList: json['donationIDList'] != null
          ? List<int>.from(json['donationIDList'])
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
      'donationIDList': donationIDList,
    };
  }
}
