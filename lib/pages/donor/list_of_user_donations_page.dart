import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../mock/mock_organization.dart';
import '../../model/model_organization.dart';
import '../../theme/widget_designs.dart';

class UserDonationsList extends StatefulWidget {
  const UserDonationsList({super.key});

  @override
  State<UserDonationsList> createState() => _UserDonationsListState();
}

class _UserDonationsListState extends State<UserDonationsList> {
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
        decoration: CustomWidgetDesigns.gradientBackground(),
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
                  // Navigator.push(
                  // context, MaterialPageRoute(builder: (context) => OrgDetailsPage(org: org)));
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
