import 'package:carousel_slider/carousel_slider.dart';
import 'package:donation_system/components/appbar.dart';
import 'package:donation_system/components/subHeader.dart';
import 'package:donation_system/mock/mock_donation_drive.dart';
import 'package:donation_system/mock/mock_donor.dart';
import 'package:donation_system/model/model_donation_drive.dart';
import 'package:donation_system/model/model_organization.dart';
import 'package:donation_system/model/model_user.dart';
import 'package:donation_system/pages/org_list.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

import '../../components/listTile.dart';
import '../../mock/mock_organization.dart';
import '../../model/model_donation.dart';
import '../drive_details_page.dart';

class DonorHomepage extends StatefulWidget {
  const DonorHomepage({super.key});

  @override
  State<DonorHomepage> createState() => _DonorHomepageState();
}

class _DonorHomepageState extends State<DonorHomepage> {
  Donor donor = MockDonor.fetchDonor();
  List<DonationDrive> drive = MockDonationDrive.fetchMany();
  late Size screen = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Elbi Donation System'),
      body: SingleChildScrollView(
        child: Container(
            color: AppColors.aliceBlue,
            // decoration: CustomWidgetDesigns.gradientBackground(),
            height: screen.height + 100,
            child: Column(
              children: [
                spacer,
                header,
                const SubHeader(title: "Featured Drives", route: "/org-list"),
                carouselSlider(),
                spacer,
                const SubHeader(
                  title: "Recent Donations",
                  route: "/user-donation-list",
                ),
                _buildRecentDonations(),
              ],
            )),
      ),
    );
  }

  Widget get header => Column(
        children: [
          Text("Hello, ${donor.name}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const Text("A little help goes a long way!"),
        ],
      );

  Widget carouselSlider() => CarouselSlider(
      items: drive
          .map((drive) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DriveDetailsPage(donationDrive: drive)));
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
                        color: AppColors.tiffanyBlue,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(drive.title,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(drive.description, style: const TextStyle(fontSize: 15)),
                            spacer,
                            Text(drive.status, style: const TextStyle(fontSize: 15)),
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

  Widget _buildRecentDonations() {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          Donation dono = donor.donations[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Container(
              decoration: CustomWidgetDesigns.customTileContainer(),
              child: customDonorListTile(
                title: dono.organization.name,
                subtitle: dono.status,
              ),
            ),
          );
        },
      ),
    );
  }
}
