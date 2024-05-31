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

import '../components/appbar.dart';

class OrgDetailsPage extends StatefulWidget {
  final Organization organization;
  final bool isDonor;
  const OrgDetailsPage({super.key, required this.organization, required this.isDonor});

  @override
  State<OrgDetailsPage> createState() => _OrgDetailsPageState();
}

class _OrgDetailsPageState extends State<OrgDetailsPage> {
  late Size screen = MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.organization.orgName ?? 'Organization Details',
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
                header("Donation Drives"),
                const SizedBox(height: 20),
                carouselSlider(widget.organization.orgUsername),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header(name) {
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

  Widget driveStatus(status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status == 'Open' ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
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
                      builder: (context) =>
                          DriveDetailsPage(isDonor: true, donationDrive: drive, donor: null)),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
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
                              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                          spacer(10),
                          driveStatus(drive.driveStatus),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            height: screen.height * 0.7,
            initialPage: 0,
            enableInfiniteScroll: false,
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.antiAlias,
          ),
        );
      },
    );
  }

  Widget spacer(double height) {
    return SizedBox(height: height);
  }
}
