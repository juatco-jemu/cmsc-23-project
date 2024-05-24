import 'package:donation_system/mock/mock_organization.dart';
import 'package:donation_system/pages/org_details.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

import '../model/model_organization.dart';

//TODO:implement recent donation list (can be done by getting the last 3 donations from the database)
//TODO: add donation list to the database

class OrganizationsList extends StatefulWidget {
  final bool isPage;
  const OrganizationsList({required this.isPage, super.key});

  @override
  State<OrganizationsList> createState() => _OrganizationsListState();
}

class _OrganizationsListState extends State<OrganizationsList> {
  List<Organization> org_list = MockOrganization.fetchAll();

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
        !widget.isPage ? backButton : Container(),
        const Text("Choose an organization\nto donate to",
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
        title: const Text("Search for an Organization"),
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
          itemCount: org_list.length,
          itemBuilder: ((context, index) {
            Organization org = org_list[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: CustomWidgetDesigns.customTileContainer(),
              child: ListTile(
                leading: const Icon(
                  Icons.circle,
                  size: 50,
                  color: AppColors.yellow03,
                ),
                title: Text(org.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(org.status),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => OrgDetailsPage(org: org)));
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
