import 'package:carousel_slider/carousel_slider.dart';
import 'package:donation_system/components/appbar.dart';
import 'package:donation_system/pages/donor/list_of_user_donations_page.dart';
import 'package:donation_system/pages/signin_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

import '../../mock/mock_donor.dart';
import '../../model/model_user.dart';

class DonorProfilePage extends StatefulWidget {
  const DonorProfilePage({super.key});

  @override
  State<DonorProfilePage> createState() => _DonorProfilePageState();
}

class _DonorProfilePageState extends State<DonorProfilePage> {
  Donor donor = MockDonor.fetchDonor();
  late final coverHeight = 250 - MediaQuery.of(context).padding.top - kToolbarHeight;
  final double imageSize = 120;

  late Size screen = MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(title: "${donor.name}'s Profile Page"),
      body: SingleChildScrollView(
        child: Container(
          // decoration: CustomWidgetDesigns.gradientBackground(),
          color: AppColors.aliceBlue,
          height: screen.height - MediaQuery.of(context).padding.top - kToolbarHeight,
          child: Column(
            children: [
              _buildTop(),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const SignInPage()));
                  },
                  child: const Text("Sign In")),
              subHeader("Recent Donations"),
              _buildRecentDonations(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return Column(
      children: [
        Stack(clipBehavior: Clip.none, alignment: Alignment.bottomCenter, children: [
          profileHeaderBackground,
          Positioned(top: coverHeight - (imageSize / 2), child: profileImage),
        ]),
        spacer,
        spacer,
        Text("Hello, ${donor.name}",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget get profileHeaderBackground => SizedBox(
        width: screen.width,
        height: coverHeight,
        child: Card(
          color: AppColors.tiffanyBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(screen.width / 2, 100),
                bottomRight: Radius.elliptical(screen.width / 2, 100)),
          ),
        ),
      );

  Widget get profileImage => SizedBox(
        width: imageSize,
        height: imageSize,
        child: Card(
          color: AppColors.appWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );

  Widget get carouselSlider => CarouselSlider(
      items: donor.donations
          .map((donation) => Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: CustomWidgetDesigns.customContainer(),
                child: Column(
                  children: [
                    Text(donation.organization.name),
                    Text(donation.status),
                    Text(donation.dateTime.toString()),
                  ],
                ),
              ))
          .toList(),
      options: CarouselOptions(
        height: 350,
        initialPage: 0,
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
      ));

  Widget get spacer => const SizedBox(height: 30);

  Widget _buildRecentDonations() {
    return Expanded(
      child: ListView.builder(
        itemCount: donor.donations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Container(
              decoration: CustomWidgetDesigns.customTileContainer(),
              child: ListTile(
                title: Text(donor.donations[index].organization.name),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget subHeader(title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const UserDonationsList()));
                },
                child: const Text("View All")),
          ],
        ),
      );
}
