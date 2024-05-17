import 'package:donation_system/mock/mock_donation_drive.dart';

import '../model/model_organization.dart';

class MockOrganization extends Organization {
  MockOrganization({
    required super.name,
    required super.proofsOfLegitimacy,
    required super.status,
    required super.about,
    required super.donationDrives,
  });

  static Organization fetchOne() {
    Organization org = Organization(
      name: "Red Cross",
      proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
      status: "Open",
      about: "Red Cross is a humanitarian organization",
      donationDrives: [],
    );
    org.donationDrives.add(MockDonationDrive.fetchOne());
    return org;
  }

  static List<Organization> fetchAll() {
    return [
      Organization(
        name: "Red Cross",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Open",
        about: "Red Cross is a humanitarian organization",
        donationDrives: [MockDonationDrive.fetchOne()],
      ),
      Organization(
        name: "Caritas",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Open",
        about: "Caritas is a humanitarian organization",
        donationDrives: MockDonationDrive.fetchMany(),
      ),
      Organization(
        name: "World Vision",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Closed",
        about: "World Vision is a humanitarian organization",
        donationDrives: MockDonationDrive.fetchMany(),
      ),
      Organization(
        name: "UNICEF",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Open",
        about: "UNICEF is a humanitarian organization",
        donationDrives: [MockDonationDrive.fetchOne()],
      ),
      Organization(
        name: "Save the Children",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Closed",
        about: "Save the Children is a humanitarian organization",
        donationDrives: [],
      ),
      Organization(
        name: "Habitat for Humanity",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Open",
        about: "Habitat for Humanity is a humanitarian organization",
        donationDrives: MockDonationDrive.fetchMany(),
      ),
      Organization(
        name: "Red Cross",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Open",
        about: "Red Cross is a humanitarian organization",
        donationDrives: [],
      ),
      Organization(
        name: "Caritas",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Open",
        about: "Caritas is a humanitarian organization",
        donationDrives: MockDonationDrive.fetchMany(),
      ),
      Organization(
        name: "World Vision",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Closed",
        about: "World Vision is a humanitarian organization",
        donationDrives: [MockDonationDrive.fetchOne()],
      ),
      Organization(
        name: "UNICEF",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Open",
        about: "UNICEF is a humanitarian organization",
        donationDrives: [MockDonationDrive.fetchOne()],
      ),
      Organization(
        name: "Save the Children",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Closed",
        about: "Save the Children is a humanitarian organization",
        donationDrives: MockDonationDrive.fetchMany(),
      ),
      Organization(
        name: "Habitat for Humanity",
        proofsOfLegitimacy: ["Business Permit", "DTI Registration"],
        status: "Open",
        about: "Habitat for Humanity is a humanitarian organization",
        donationDrives: MockDonationDrive.fetchMany(),
      ),
    ];
  }
}
