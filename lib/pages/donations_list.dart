import 'package:donation_system/mock/mock_donation_drive.dart';
import 'package:donation_system/mock/mock_organization.dart';
import 'package:donation_system/pages/donation_details_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

import '../model/model_organization.dart';
import 'org_details_page.dart';

class DonationsList extends StatefulWidget {
  final bool isAllDonations;
  const DonationsList({super.key, required this.isAllDonations});

  @override
  State<DonationsList> createState() => _DonationsListState();
}

class _DonationsListState extends State<DonationsList> {
  List list1 = [];
  String title = "";
  String subtitle = "";

  @override
  void initState() {
    super.initState();
    list1 = widget.isAllDonations
        ? MockOrganization.fetchAll()
        : MockDonationDrive.fetchMany().first.driveDonationList!;
  }

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
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        widget.isAllDonations ? Container() : backButton,
        Text(widget.isAllDonations ? "All Donations List" : "Drive Donations List",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
        title: const Text("Search for a Donation"),
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
          itemCount: list1.length,
          itemBuilder: ((context, index) {
            dynamic item = list1[index];

            if (widget.isAllDonations) {
              title = item.orgName!;
              subtitle = item.orgStatus!;
            } else {
              title = item.donorUsername!;
              subtitle = item.status!;
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: CustomWidgetDesigns.customTileContainer(),
              child: ListTile(
                leading: const Icon(
                  Icons.circle,
                  size: 50,
                  color: AppColors.yellow03,
                ),
                title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(subtitle),
                onTap: () {
                  if (widget.isAllDonations) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrgDetailsPage(
                                  org: item,
                                  isDonor: false,
                                )));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const DonationDetailsPage()));
                  }
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
