import 'package:carousel_slider/carousel_slider.dart';
import 'package:donation_system/components/appbar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "${donor.name}'s Profile Page"),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: CustomWidgetDesigns.gradientBackground(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                profileHeader,
                spacer,
                spacer,
                carouselSlider,
                spacer,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get profileHeader => Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: CustomWidgetDesigns.customContainer(),
        child: Text(
          "Name: ${donor.name}",
          style: const TextStyle(fontSize: 20),
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
}
