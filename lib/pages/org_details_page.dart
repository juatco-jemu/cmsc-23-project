import 'package:carousel_slider/carousel_slider.dart';
import 'package:donation_system/mock/mock_donor.dart';
import 'package:donation_system/model/model_organization.dart';
import 'package:donation_system/pages/donate_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

import '../components/appbar.dart';
import '../mock/mock_donation_drive.dart';
import '../model/model_donor.dart';
import '../model/model_drive.dart';
import 'drive_details_page.dart';

class OrgDetailsPage extends StatefulWidget {
  final Organization org;
  const OrgDetailsPage({super.key, required this.org});

  @override
  State<OrgDetailsPage> createState() => _OrgDetailsPageState();
}

class _OrgDetailsPageState extends State<OrgDetailsPage> {
  Donor donor = MockDonor.fetchDonor();
  List<DonationDrive> drive = MockDonationDrive.fetchMany();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Organization Details",
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
                orgName(widget.org.orgName),
                // orgAbout(widget.org.or),
                const SizedBox(height: 20),
                const Text("Donation Drives"),
                carouselSlider(),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DonateForm()));
        },
        child: const Text("Donate"),
      ),
    );
  }

  Widget carouselSlider() => CarouselSlider(
      items: drive
          .map((drive) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DriveDetailsPage(
                                donationDrive: drive,
                                isDonor: false,
                              )));
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
                            Text(drive.driveName!,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            // Text(drive.description, style: const TextStyle(fontSize: 15)),
                            // spacer,
                            Text(drive.driveStatus!, style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))
          .toList(),
      options: CarouselOptions(
        height: 350,
        initialPage: 0,
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.antiAlias,
      ));
  Widget get spacer => const SizedBox(height: 30);
}
