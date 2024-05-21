import 'model_donation.dart';

class Users {
  String name;
  String username;
  String email;
  List<String> addresses;
  String contactNo;

  Users({
    required this.name,
    required this.username,
    required this.email,
    required this.addresses,
    required this.contactNo,
  });
}

class Donor extends Users {
  Donor({
    required super.name,
    required super.username,
    required super.email,
    required super.addresses,
    required super.contactNo,
  });

  List<Donation> donations = [];
}
