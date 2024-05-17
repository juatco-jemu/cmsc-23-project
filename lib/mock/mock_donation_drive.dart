import 'package:donation_system/mock/mock_organization.dart';

import '../model/model_donation_drive.dart';

class MockDonationDrive extends DonationDrive {
  MockDonationDrive({
    required super.organization,
    required super.id,
    required super.title,
    required super.description,
    required super.location,
    required super.status,
  });

  static DonationDrive fetchOne() {
    return DonationDrive(
      organization: MockOrganization.fetchOne(),
      id: "123456",
      title: "Typhoon Relief",
      description: "Donations for typhoon victims",
      location: "Cebu City, Cebu",
      status: "Open",
    );
  }
}
