import 'package:donation_system/model/model_donation.dart';

import '../model/model_organization.dart';
import '../model/model_user.dart';

class MockDonation extends Donation {
  MockDonation({
    required super.donor,
    required super.organization,
    required super.itemCategories,
    required super.itemDescription,
    required super.weight,
    required super.photoUrl,
    required super.pickupOrDropOff,
    required super.dateTime,
    required super.address,
    required super.contactNo,
    required super.qrCode,
    required super.status,
  });

  static Donation fetchAny() {
    return Donation(
      donor: User(
        name: "Jemuel",
        username: "jemueljuatco",
        email: "jmjuatco@gmail.com",
        password: "password",
        addresses: ["Cebu City, Cebu"],
        contactNo: "09123456789",
      ),
      organization: Organization(
        name: "Red Cross",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Verified",
        about: "Red Cross is a humanitarian organization",
      ),
      itemCategories: ["Clothes", "Food"],
      itemDescription: "Clothes and food",
      weight: 10.0,
      photoUrl: "https://via.placeholder.com/150",
      pickupOrDropOff: "Pickup",
      dateTime: DateTime.now(),
      address: "Cebu City, Cebu",
      contactNo: "09123456789",
      qrCode: "123456",
      status: "Pending",
    );
  }
}
