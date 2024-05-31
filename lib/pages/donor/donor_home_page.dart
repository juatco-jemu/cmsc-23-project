import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/components/subHeader.dart';
import 'package:donation_system/model/model_donation.dart';
import 'package:donation_system/pages/org_list_page.dart';
import 'package:donation_system/providers/provider_donation.dart';
import 'package:donation_system/providers/provider_drive.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/model_donor.dart';
import '../../model/model_drive.dart';
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
                    title: "Recent Drives",
                    route: OrganizationsList(
                      isPage: false,
                      isDonor: true,
                      isAdmin: false,
                    )),
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
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No donation drives available');
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
                      isDonor: true,
                      donationDrive: drive,
                      donor: widget.donor
                    )
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
    return StreamBuilder<QuerySnapshot>(
      stream: context.watch<DonationsProvider>().getDonationForDonor(widget.donor!.username!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No donation yet');
        }

        var donations = snapshot.data!.docs.map((doc) {
          return Donation.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        return Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              itemCount: donations.length,
              itemBuilder: (context, index) {
                Donation donation = donations[index];

                return FutureBuilder<String?>(
                  future: context.watch<DonationsProvider>().getDriveNameByDriveID(donation.driveID),
                  builder: (context, driveNameSnapshot) {
                    if (driveNameSnapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: CustomWidgetDesigns.customTileContainer(),
                        child: const ListTile(
                          title: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (!driveNameSnapshot.hasData || driveNameSnapshot.data == null) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: CustomWidgetDesigns.customTileContainer(),
                        child: const ListTile(
                          title: Text('Drive name not found'),
                        ),
                      );
                    }

                    String driveName = driveNameSnapshot.data!;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: CustomWidgetDesigns.customTileContainer(),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ID: ${donation.donationID}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              driveName,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                donation.status == 'Confirmed' ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            donation.status.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

}
