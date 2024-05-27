import '../model/model_donor.dart';
import 'mock_donation.dart';

class MockDonor extends Donor {
  MockDonor({
    required super.firstName,
    required super.lastName,
    required super.username,
    required super.email,
    required super.addressList,
    required super.contactNumber,
  });

  static Donor fetchDonor() {
    Donor jemu = Donor(
        firstName: "Jemuel",
        lastName: "Juatco",
        username: "jemueljuatco",
        email: "jmjuatco@gmail.com",
        addressList: ["Cebu City, Cebu"],
        contactNumber: "09123456789",
        donationList: []);

    jemu.donationList!.add(MockDonation.fetchDonation(jemu));
    jemu.donationList!.add(MockDonation.fetchDonation(jemu));
    jemu.donationList!.add(MockDonation.fetchDonation(jemu));
    jemu.donationList!.add(MockDonation.fetchDonation(jemu));
    jemu.donationList!.add(MockDonation.fetchDonation(jemu));

    return jemu;
  }
}
