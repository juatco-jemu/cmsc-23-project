import 'package:donation_system/mock/mock_organization.dart';
import 'package:donation_system/pages/org_details.dart';
import 'package:flutter/material.dart';

import '../model/model_organization.dart';

class DonationList extends StatefulWidget {
  const DonationList({super.key});

  @override
  State<DonationList> createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  List<Organization> org_list = MockOrganization.fetchAll();
  @override
  Widget build(BuildContext context) {
    // Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    return Scaffold(
        // drawer: drawer,
        appBar: AppBar(
          title: const Text("Elbi Donation System"),
        ),
        body: ListView.builder(
          itemCount: org_list.length,
          itemBuilder: ((context, index) {
            Organization org = org_list[index];
            return ListTile(
              title: Text(org.name),
              subtitle: Text(org.about),
              trailing: Text(org.status),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => OrgDetailsPage(org: org)));
              },
            );
          }),
        ));
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
