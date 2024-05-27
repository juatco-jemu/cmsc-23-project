import '../model/model_drive.dart';

class MockDonationDrive extends DonationDrive {
  MockDonationDrive({
    // required super.organization,
    required super.driveName,
    required super.driveDescription,
    required super.driveLocation,
    required super.driveStatus,
    required super.driveImgURL,
    required super.driveDonationList,
  });

  static DonationDrive fetchOne() {
    return DonationDrive(
      // organization: org,

      driveName: "Typhoon Relief",
      driveDescription: "Donations for typhoon victims",
      driveLocation: "Cebu City, Cebu",
      driveStatus: "Open",
      driveDonationList: [],
      driveImgURL: [],
    );
  }

  static List<DonationDrive> fetchMany() {
    return [
      DonationDrive(
        // organization: org,

        driveName: "Typhoon Relief",
        driveDescription:
            "Join us in providing critical aid to those affected by the recent typhoon with our Typhoon Relief Donation Drive app. Designed for convenience and efficiency, our app enables you to contribute to relief efforts seamlessly, ensuring that your donations make a direct impact on the lives of those in need.",
        driveLocation: "Cebu City, Cebu",
        driveStatus: "Open",
        driveDonationList: [],
        driveImgURL: [],
      ),
      DonationDrive(
        // organization: org,

        driveName: "Earthquake Relief",
        driveDescription:
            "Be a beacon of hope for earthquake survivors with our Earthquake Relief Donation Drive app. This user-friendly platform empowers you to provide essential aid swiftly and effectively, ensuring that your contributions reach those in urgent need.",
        driveLocation: "Bohol City, Bohol",
        driveStatus: "Open",
        driveDonationList: [],
        driveImgURL: [],
      ),
      DonationDrive(
        // organization: org,

        driveName: "Fire Relief",
        driveDescription:
            "Support communities devastated by wildfires with our Fire Relief Donation Drive app. This intuitive app allows you to provide crucial aid quickly and efficiently, ensuring your contributions directly help those in urgent need.",
        driveLocation: "Manila City, Manila",
        driveStatus: "Closed",
        driveDonationList: [],
        driveImgURL: [],
      ),
      DonationDrive(
        // organization: org,

        driveName: "Flood Relief",
        driveDescription:
            "Stand in solidarity with flood-affected communities by using our Flood Relief Donation Drive app. This user-friendly platform allows you to provide crucial aid swiftly and effectively, ensuring your contributions directly assist those in urgent need.",
        driveLocation: "Davao City, Davao",
        driveStatus: "Open",
        driveDonationList: [],
        driveImgURL: [],
      ),
      DonationDrive(
        // organization: org,

        driveName: "Pandemic Relief",
        driveDescription:
            "Join us in providing essential support to those affected by the pandemic with our Pandemic Relief Donation Drive app. This easy-to-use platform enables you to contribute swiftly and effectively, ensuring that your donations directly help individuals and communities in need.",
        driveLocation: "Cebu City, Cebu",
        driveStatus: "Closed",
        driveDonationList: [],
        driveImgURL: [],
      ),
      DonationDrive(
        // organization: org,

        driveName: "Tsunami Relief",
        driveDescription:
            "Stand in solidarity with flood-affected communities by using our Flood Relief Donation Drive app. This user-friendly platform allows you to provide crucial aid swiftly and effectively, ensuring your contributions directly assist those in urgent need.",
        driveLocation: "Cebu City, Cebu",
        driveStatus: "Open",
        driveDonationList: [],
        driveImgURL: [],
      ),
    ];
  }
}
