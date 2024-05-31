import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/model/model_drive.dart';
import 'package:donation_system/pages/drive_details_page.dart';
import 'package:donation_system/pages/organization/org_add_drive_page.dart';
import 'package:donation_system/providers/provider_drive.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgDonationDriveListPage extends StatefulWidget {
  final String orgUsername;
  final bool isPage;

  const OrgDonationDriveListPage({Key? key, required this.orgUsername, required this.isPage})
      : super(key: key);

  @override
  State<OrgDonationDriveListPage> createState() => _OrgDonationDriveListPageState();
}

class _OrgDonationDriveListPageState extends State<OrgDonationDriveListPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        // decoration: CustomWidgetDesigns.gradientBackground(),
        color: AppColors.backgroundYellow,
        child: Column(
          children: [
            spacer,
            _buildHeader(),
            _buildSearch(),
            _buildList(widget.orgUsername),
          ],
        ),
      ),
      floatingActionButton: _buildAddDriveButton(widget.orgUsername),
    );
  }

  Widget _buildAddDriveButton(String orgUsername) {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.yellow03,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddDonationDrivePage(orgUsername: orgUsername),
          ),
        );
      },
      label: const Text("ADD DRIVE"),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        !widget.isPage ? backButton : Container(),
        const Text(
          "All Donation Drives\nin your organization",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset('assets/images/cloud01.png', height: 80),
        ),
      ],
    );
  }

  Widget get backButton => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      );

  Widget _buildSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: CustomWidgetDesigns.customTileContainer(),
      child: ListTile(
        title: const Text("Search for a Drive"),
        trailing: const Icon(Icons.search),
        onTap: () {
          // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => OrgDetailsPage(org: org)));
        },
      ),
    );
  }

  Widget _buildList(String orgUsername) {
    Stream<QuerySnapshot> donationDriveStream =
        context.watch<DonationDriveProvider>().getDonationDrivesForOrganization(orgUsername);
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: donationDriveStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No donation drives found'));
          }

          var donationDrives = snapshot.data!.docs;

          return ListView.builder(
            itemCount: donationDrives.length,
            itemBuilder: (context, index) {
              var document = donationDrives[index];
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              DonationDrive donationDrive = DonationDrive.fromJson(data);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: CustomWidgetDesigns.customTileContainer(),
                child: ListTile(
                  // leading: const Icon(
                  //   Icons.circle,
                  //   size: 50,
                  //   color: AppColors.yellow03,
                  // ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   'ID: ${donationDrive.driveID}',
                      //   style: const TextStyle(
                      //     fontSize: 12,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      const SizedBox(height: 4),
                      Text(
                        donationDrive.driveName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(donationDrive.driveLocation),
                    ],
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: donationDrive.driveStatus == 'Open' ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      donationDrive.driveStatus.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DriveDetailsPage(
                          donationDrive: donationDrive,
                          isDonor: false,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget get spacer => const SizedBox(height: 40);
}
