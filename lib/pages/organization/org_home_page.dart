import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/components/subHeader.dart';
import 'package:donation_system/model/model_donation.dart';
import 'package:donation_system/pages/organization/org_scan_qr_page.dart';
import 'package:donation_system/providers/provider_donation.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return StreamBuilder<QuerySnapshot>(
      stream: context.watch<DonationsProvider>().getDonationForOrganization(widget.orgUsername),
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
