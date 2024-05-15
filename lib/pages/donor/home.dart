import 'package:carousel_slider/carousel_slider.dart';
import 'package:donation_system/mock/mock_donor.dart';
import 'package:donation_system/model/model_user.dart';
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
    return SingleChildScrollView(
      child: Container(
          decoration: CustomWidgetDesigns.gradientBackground(),
          child: Column(
            children: [
              Text("Hello, ${donor.name}"),
              const Text("A little help goes a long way!"),
              viewAll,
              carouselSlider,
              const Text("Your recent Donations"),
              viewAll,
              carouselSlider,
            ],
          )),
    );
  }

  Widget get viewAll => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("View all"),
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
}
