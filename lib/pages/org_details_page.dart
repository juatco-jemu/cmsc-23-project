import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/model/model_drive.dart';
import 'package:donation_system/model/model_organization.dart';
import 'package:donation_system/pages/drive_details_page.dart';
import 'package:donation_system/providers/provider_drive.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgDetailsPage extends StatefulWidget {
  final Organization organization;
  final bool isDonor;
  const OrgDetailsPage({super.key, required this.organization, required this.isDonor});

  @override
  State<OrgDetailsPage> createState() => _OrgDetailsPageState();
}

class _OrgDetailsPageState extends State<OrgDetailsPage> {
  // Donor donor = MockDonor.fetchDonor();
  // List<DonationDrive> drive = MockDonationDrive.fetchMany();
  String? _status;

  @override
  void initState() {
    super.initState();
    _status = widget.organization.orgStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.organization.orgName ?? 'Organization Details'),
      ),
      body: Container(
        // decoration: CustomWidgetDesigns.gradientBackground(),
        color: AppColors.backgroundYellow,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                orgName(widget.organization.orgName),
                // orgAbout(widget.organizationor),
                const SizedBox(height: 20),
                const Text("Donation Drives"),
                carouselSlider(widget.organization.orgUsername),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orgName(name) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text(
        name,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget orgAbout(about) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text(
        about,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Widget donateButton(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ElevatedButton(
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const DonateFormPage()));
        },
        child: const Text("Donate"),
      ),
    );
  }

  Widget carouselSlider(orgUsername) {
    return StreamBuilder<QuerySnapshot>(
      stream: context.watch<DonationDriveProvider>().getDonationDrivesForOrganization(orgUsername),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No donation drives available');
        }

        var donationDrive = snapshot.data!.docs.map((doc) {
          return DonationDrive.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        return CarouselSlider(
          items: donationDrive.map((drive) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DriveDetailsPage(
                      donationDrive: drive,
                      isDonor: true,
                    ),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: CustomWidgetDesigns.customContainer(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.yellow01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(drive.driveName,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(drive.driveStatus, style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 350,
            initialPage: 0,
            enableInfiniteScroll: false,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.antiAlias,
          ),
        );
      },
    );
  }

  Widget get spacer => const SizedBox(height: 30);
}