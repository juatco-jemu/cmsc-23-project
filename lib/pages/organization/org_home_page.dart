import 'package:donation_system/components/subHeader.dart';
import 'package:donation_system/pages/organization/org_donation_details_page.dart';
import 'package:donation_system/pages/organization/org_scan_qr_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

import '../../components/listTile.dart';

class OrgHomePage extends StatefulWidget {
  final String orgUsername;
  const OrgHomePage({super.key, required this.orgUsername});

  @override
  State<OrgHomePage> createState() => _OrgHomePageState();
}

class _OrgHomePageState extends State<OrgHomePage> {
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
                spacer,
                const SubHeader(
                  title: "List of Donations",
                  route: "/user-donation-list",
                ),
                _buildRecentDonations(),
                spacer
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.yellow03,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrgScanQRCodePage(),
            ),
          );
        },
        child: const Icon(Icons.qr_code),
      ),
    );
  }

  Widget get header => Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset(
                'assets/images/cloud01.png',
                // width: screen.width,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Hello, ",
                  style: TextStyle(
                      fontFamily: "Baguet Script",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.yellow03)),
              Text(widget.orgUsername,
                  style: const TextStyle(
                      fontFamily: "Baguet Script",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkYellow01)),
            ],
          ),
          const Text("A little help goes a long way!"),
        ],
      );

  Widget get spacer => const SizedBox(height: 30);

  Widget _buildRecentDonations() {
    // Donor? donor = context.watch<DonorsProvider>().donorData;

    // if (donor?.donationIDList == null || donor!.donationIDList!.isEmpty) {
    //   return const Center(child: Text('No donations yet'));
    // }

    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrgDonationDetailsPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: CustomWidgetDesigns.customTileContainer(),
                  child: customDonationListTile(
                    title: "Donation ID: 1",
                    subtitle: "Typhoon Drive",
                    trailing: "Pending",
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
