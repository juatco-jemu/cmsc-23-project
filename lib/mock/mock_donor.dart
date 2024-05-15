import 'package:donation_system/model/model_user.dart';

import 'mock_donation.dart';

class MockDonor extends Donor {
  MockDonor({
    required super.name,
    required super.username,
    required super.email,
    required super.addresses,
    required super.contactNo,
  });

  static Donor fetchDonor() {
    Donor jemu = Donor(
      name: "Jemuel",
      username: "jemueljuatco",
      email: "jmjuatco@gmail.com",
      addresses: ["Cebu City, Cebu"],
      contactNo: "09123456789",
    );

    jemu.donations.add(MockDonation.fetchDonation(jemu));
    jemu.donations.add(MockDonation.fetchDonation(jemu));
    jemu.donations.add(MockDonation.fetchDonation(jemu));
    jemu.donations.add(MockDonation.fetchDonation(jemu));
    jemu.donations.add(MockDonation.fetchDonation(jemu));

    return jemu;
  }
}
