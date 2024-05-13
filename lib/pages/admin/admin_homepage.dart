import 'package:donation_system/mock/mock_organization.dart';
import 'package:donation_system/pages/admin/admin_all_org_and_donos_page.dart';
import 'package:donation_system/pages/admin/admin_approval_page.dart';
import 'package:donation_system/pages/admin/admin_viewall_donors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../model/model_organization.dart';

//TODO:implement recent donation list (can be done by getting the last 3 donations from the database)
//TODO: add donation list to the database
//ISSUE: navigation bar is not working properly

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Organization> org_list = MockOrganization.fetchAll();
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    AdminViewAll(),
    AdminApprovalPage(),
    AdminViewAllDonors(),
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    return Scaffold(
        // drawer: drawer,
        appBar: const CustomAppBar(
          title: "Elbi Donation System Admin",
        ),
        bottomNavigationBar: botNavBar,
        body: Center(
            // child: Container(
            // height: screenHeight,
            // width: screenWidth,
            // decoration: CustomWidgetDesigns.gradientBackground(),
            // child: ListView.builder(
            //   itemCount: org_list.length,
            //   itemBuilder: ((context, index) {
            //     Organization org = org_list[index];
            //     return Container(
            //       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //       decoration: CustomWidgetDesigns.customTileContainer(),
            //       child: ListTile(
            //         title: Text(org.name),
            //         subtitle: Text(org.about),
            //         trailing: Text(org.status),
            //         onTap: () {
            //           Navigator.push(
            //               context, MaterialPageRoute(builder: (context) => OrgDetailsPage(org: org)));
            //         },
            //       ),
            //     );
            //   }),
            // ),
            child: _pages.elementAt(_selectedIndex)));
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

  BottomNavigationBar get botNavBar => BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.approval),
              label: 'Approval',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Donors',
            ),
          ]);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
