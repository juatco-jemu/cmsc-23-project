import 'package:donation_system/mock/mock_organization.dart';
import 'package:donation_system/pages/org_details.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

import '../components/appbar.dart';
import '../model/model_organization.dart';

//TODO:implement recent donation list (can be done by getting the last 3 donations from the database)
//TODO: add donation list to the database

class DonationList extends StatefulWidget {
  const DonationList({super.key});

  @override
  State<DonationList> createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  List<Organization> org_list = MockOrganization.fetchAll();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Choose an Organization\nto Donate to",
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        // decoration: CustomWidgetDesigns.gradientBackground(),
        color: AppColors.aliceBlue,
        child: ListView.builder(
          itemCount: org_list.length,
          itemBuilder: ((context, index) {
            Organization org = org_list[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: CustomWidgetDesigns.customTileContainer(),
              child: ListTile(
                title: Text(org.name),
                subtitle: Text(org.about),
                trailing: Text(org.status),
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

  Drawer get drawer => Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(child: Text("Todo")),
        ListTile(
          title: const Text('Details'),
          onTap: () {
            // Navigator.push(
            // context, MaterialPageRoute(builder: (context) => const UserDetailsPage()));
          },
        ),
        ListTile(
          title: const Text('Todo List'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/");
          },
        ),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            // context.read<UserAuthProvider>().signOut();
            Navigator.pop(context);
          },
        ),
      ]));
}
