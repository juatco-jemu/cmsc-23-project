import 'package:donation_system/model/model_donation_drive.dart';

class Organization {
  String name;
  List<String> proofsOfLegitimacy;
  String status;
  String about;
  List<DonationDrive> donationDrives = [];

  Organization({
    required this.name,
    required this.proofsOfLegitimacy,
    required this.status,
    required this.about,
    required this.donationDrives,
  });
}
