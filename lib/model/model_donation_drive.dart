import 'package:donation_system/model/model_organization.dart';

class DonationDrive {
  Organization organization;
  String id;
  String title;
  String description;
  String location;
  String status;

  DonationDrive(
      {required this.organization,
      required this.id,
      required this.title,
      required this.description,
      required this.location,
      required this.status});
}
