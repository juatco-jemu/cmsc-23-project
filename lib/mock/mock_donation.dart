import 'package:donation_system/mock/mock_organization.dart';
import 'package:donation_system/model/model_donation.dart';

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

  static Donation fetchDonation(donor) {
    return Donation(
      donor: donor,
      organization: MockOrganization.fetchOne(),
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
