import '../model/model_donation_drive.dart';

class MockDonationDrive extends DonationDrive {
  MockDonationDrive({
    // required super.organization,
    required super.id,
    required super.title,
    required super.description,
    required super.location,
    required super.status,
  });

  static DonationDrive fetchOne() {
    return DonationDrive(
      // organization: org,
      id: "123456",
      title: "Typhoon Relief",
      description: "Donations for typhoon victims",
      location: "Cebu City, Cebu",
      status: "Open",
    );
  }

  static List<DonationDrive> fetchMany() {
    return [
      DonationDrive(
        // organization: org,
        id: "123456",
        title: "Typhoon Relief",
        description: "Donations for typhoon victims",
        location: "Cebu City, Cebu",
        status: "Open",
      ),
      DonationDrive(
        // organization: org,
        id: "123456",
        title: "Earthquake Relief",
        description: "Donations for earthquake victims",
        location: "Bohol City, Bohol",
        status: "Open",
      ),
      DonationDrive(
        // organization: org,
        id: "123456",
        title: "Fire Relief",
        description: "Donations for fire victims",
        location: "Manila City, Manila",
        status: "Closed",
      ),
      DonationDrive(
        // organization: org,
        id: "123456",
        title: "Flood Relief",
        description: "Donations for flood victims",
        location: "Davao City, Davao",
        status: "Open",
      ),
      DonationDrive(
        // organization: org,
        id: "123456",
        title: "Pandemic Relief",
        description: "Donations for pandemic victims",
        location: "Cebu City, Cebu",
        status: "Closed",
      ),
      DonationDrive(
        // organization: org,
        id: "123456",
        title: "Tsunami Relief",
        description: "Donations for tsunami victims",
        location: "Cebu City, Cebu",
        status: "Open",
      ),
    ];
  }
}
