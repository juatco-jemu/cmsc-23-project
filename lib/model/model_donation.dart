import './model_organization.dart';
import 'model_user.dart';

class Donation {
  Users donor;
  Organization organization;
  List<String> itemCategories;
  String itemDescription;
  double weight;
  String photoUrl;
  String pickupOrDropOff;
  DateTime dateTime;
  String address;
  String contactNo;
  String qrCode;
  String status;

  Donation({
    required this.donor,
    required this.organization,
    required this.itemCategories,
    required this.itemDescription,
    required this.weight,
    required this.photoUrl,
    required this.pickupOrDropOff,
    required this.dateTime,
    required this.address,
    required this.contactNo,
    required this.qrCode,
    required this.status,
  });
}
