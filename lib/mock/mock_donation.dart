import 'package:donation_system/model/model_donation.dart';

class MockDonation extends Donation {
  MockDonation({
    required super.donationID,
    required super.itemsToDonate,
    required super.weight,
    required super.mode,
    required super.dateTime,
    required super.addresses,
    required super.contactNumber,
    required super.imageURL,
    required super.qrCode,
    required super.status,
  });

  static Donation fetchDonation(donor) {
    return Donation(
      donationID: 1,
      itemsToDonate: ["Clothes", "Food"],
      weight: 10,
      mode: "Pickup",
      dateTime: DateTime.now(),
      addresses: ["Cebu City, Cebu"],
      contactNumber: "09123456789",
      imageURL: "https://www.google.com",
      qrCode: "123456",
      status: "Pending",
    );
  }
}
