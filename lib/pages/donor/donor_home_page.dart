import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/components/subHeader.dart';
import 'package:donation_system/pages/org_list_page.dart';
import 'package:donation_system/providers/provider_drive.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/listTile.dart';
import '../../model/model_donor.dart';
import '../../model/model_drive.dart';
import '../../providers/provider_donors.dart';
import '../drive_details_page.dart';

class DonorHomePage extends StatefulWidget {
  final Donor? donor;

  const DonorHomePage({super.key, this.donor});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  late Size screen = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            color: AppColors.backgroundYellow,
            height: screen.height + 100,
            child: Column(
              children: [
                spacer,
                header,
                const SubHeader(
                    title: "Recent Drives", route: OrganizationsList(isPage: false, isDonor: true)),
                carouselSlider(),
                spacer,
                const SubHeader(
                  title: "Recent Donations",
                  route: "/user-donation-list",
                ),
                _buildRecentDonations(),
                spacer
              ],
            )),
      ),
    );
  }

  Widget get header => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset(
                'assets/images/cloud01.png',
                height: 110,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Hello, ",
                  style: TextStyle(
                      fontFamily: "Baguet Script",
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.yellow03)),
              Text(widget.donor?.firstName ?? '',
                  style: const TextStyle(
                      fontFamily: "Baguet Script",
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkYellow01)),
            ],
          ),
          const Text("A little help goes a long way!"),
        ],
      );

  Widget carouselSlider() {
    return StreamBuilder<QuerySnapshot>(
      stream: context.watch<DonationDriveProvider>().donationDrive,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No donation drives available');
        }

        var donationDrive = snapshot.data!.docs.map((doc) {
          return DonationDrive.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        var firstFiveDrives = donationDrive.take(5).toList();

        return CarouselSlider(
          items: firstFiveDrives.map((drive) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DriveDetailsPage(
                          isDonor: true, donationDrive: drive, donor: widget.donor)),
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
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
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

  Widget _buildRecentDonations() {
    Donor? donor = context.watch<DonorsProvider>().donorData;

    if (donor?.donationIDList == null || donor!.donationIDList!.isEmpty) {
      return const Center(child: Text('No donations yet'));
    }

    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: (donor.donationIDList!.length > 3) ? 3 : donor.donationIDList!.length,
          itemBuilder: (context, index) {
            int? dono = donor.donationIDList![index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Container(
                decoration: CustomWidgetDesigns.customTileContainer(),
                child: customDonorListTile(
                  title: "Donation ID: $dono",
                  subtitle: dono.toString(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
