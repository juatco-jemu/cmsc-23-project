import 'package:carousel_slider/carousel_slider.dart';
import 'package:donation_system/components/appbar.dart';
import 'package:donation_system/mock/mock_donor.dart';
import 'package:donation_system/model/model_user.dart';
import 'package:donation_system/pages/org_list.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

class DonorHomepage extends StatefulWidget {
  const DonorHomepage({super.key});

  @override
  State<DonorHomepage> createState() => _DonorHomepageState();
}

class _DonorHomepageState extends State<DonorHomepage> {
  Donor donor = MockDonor.fetchDonor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Elbi Donation System'),
      body: SingleChildScrollView(
        child: Container(
            decoration: CustomWidgetDesigns.gradientBackground(),
            child: Column(
              children: [
                spacer,
                header,
                subHeader("Featured Organizations"),
                carouselSlider,
                spacer,
                subHeader("Recent Donations"),
                carouselSlider,
                spacer,
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

  Widget subHeader(title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const DonationList()));
                },
                child: const Text("View All")),
          ],
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
