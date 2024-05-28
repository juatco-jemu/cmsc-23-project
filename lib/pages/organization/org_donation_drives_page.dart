import 'package:donation_system/mock/mock_donation_drive.dart';
import 'package:donation_system/model/model_drive.dart';
import 'package:donation_system/pages/drive_details_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

import 'org_add_drive.dart';

class OrgDriveListPage extends StatefulWidget {
  final bool isPage;
  const OrgDriveListPage({required this.isPage, super.key});

  @override
  State<OrgDriveListPage> createState() => _OrgDriveListPageState();
}

class _OrgDriveListPageState extends State<OrgDriveListPage> {
  List<DonationDrive> orgDriveList = MockDonationDrive.fetchMany();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
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
            _buildList(),
          ],
        ),
      ),
      floatingActionButton: _buildAddDriveButton(),
    );
  }

  Widget _buildAddDriveButton() {
    return FloatingActionButton(
        backgroundColor: AppColors.yellow03,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddDrivePage()));
        },
        child: const Icon(Icons.add));
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        !widget.isPage ? backButton : Container(),
        const Text("All Donation Drives\nin your organization",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset('assets/images/cloud01.png', height: 80),
        )
      ],
    );
  }

  Widget get backButton => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
            onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
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

  Widget _buildList() {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: orgDriveList.length,
          itemBuilder: ((context, index) {
            DonationDrive drive = orgDriveList[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: CustomWidgetDesigns.customTileContainer(),
              child: ListTile(
                leading: const Icon(
                  Icons.circle,
                  size: 50,
                  color: AppColors.yellow03,
                ),
                title: Text(drive.driveName!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(drive.driveStatus!),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DriveDetailsPage(
                                donationDrive: drive,
                                isDonor: false,
                              )));
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget get spacer => const SizedBox(height: 40);
}
