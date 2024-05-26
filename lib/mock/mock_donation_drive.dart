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
        description:
            "Join us in providing critical aid to those affected by the recent typhoon with our Typhoon Relief Donation Drive app. Designed for convenience and efficiency, our app enables you to contribute to relief efforts seamlessly, ensuring that your donations make a direct impact on the lives of those in need.",
        location: "Cebu City, Cebu",
        status: "Open",
      ),
      DonationDrive(
        // organization: org,
        id: "123456",
        title: "Earthquake Relief",
        description:
            "Be a beacon of hope for earthquake survivors with our Earthquake Relief Donation Drive app. This user-friendly platform empowers you to provide essential aid swiftly and effectively, ensuring that your contributions reach those in urgent need.",
        location: "Bohol City, Bohol",
        status: "Open",
      ),
      DonationDrive(
        // organization: org,
        id: "123456",
        title: "Fire Relief",
        description:
            "Support communities devastated by wildfires with our Fire Relief Donation Drive app. This intuitive app allows you to provide crucial aid quickly and efficiently, ensuring your contributions directly help those in urgent need.",
        location: "Manila City, Manila",
        status: "Closed",
      ),
      DonationDrive(
        // organization: org,
        id: "123456",
        title: "Flood Relief",
        description:
            "Stand in solidarity with flood-affected communities by using our Flood Relief Donation Drive app. This user-friendly platform allows you to provide crucial aid swiftly and effectively, ensuring your contributions directly assist those in urgent need.",
        location: "Davao City, Davao",
        status: "Open",
      ),
      DonationDrive(
        // organization: org,
        id: "123456",
        title: "Pandemic Relief",
        description:
            "Join us in providing essential support to those affected by the pandemic with our Pandemic Relief Donation Drive app. This easy-to-use platform enables you to contribute swiftly and effectively, ensuring that your donations directly help individuals and communities in need.",
        location: "Cebu City, Cebu",
        status: "Closed",
      ),
      DonationDrive(
        // organization: org,
        id: "123456",
        title: "Tsunami Relief",
        description:
            "Stand in solidarity with flood-affected communities by using our Flood Relief Donation Drive app. This user-friendly platform allows you to provide crucial aid swiftly and effectively, ensuring your contributions directly assist those in urgent need.",
        location: "Cebu City, Cebu",
        status: "Open",
      ),
    ];
  }
}
