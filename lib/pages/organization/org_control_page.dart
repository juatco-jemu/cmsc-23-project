import 'package:donation_system/pages/organization/org_main_page.dart';
import 'package:donation_system/pages/organization/org_pending_page.dart';
import 'package:donation_system/providers/provider_organizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'org_rejected_page.dart';

class OrganizationControlPage extends StatefulWidget {
  final String orgEmail;

  const OrganizationControlPage({Key? key, required this.orgEmail}) : super(key: key);

  @override
  _OrganizationControlPageState createState() => _OrganizationControlPageState();
}

class _OrganizationControlPageState extends State<OrganizationControlPage> {
  late String _orgUsername;
  late String _orgStatus;

  @override
  void initState() {
    super.initState();
    fetchOrganizationDetails();
  }

  Future<void> fetchOrganizationDetails() async {
    try {
      // Get organization username and status using the user email
      String? orgUsername =
          await context.read<OrganizationsProvider>().getOrganizationUsername(widget.orgEmail);
      String? orgStatus =
          await context.read<OrganizationsProvider>().getOrganizationStatus(orgUsername!);

      setState(() {
        _orgUsername = orgUsername;
        _orgStatus = orgStatus!;
      });

      if (_orgStatus == "Pending") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PendingOrgPage()),
        );
      } else if (_orgStatus == "Rejected") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrgRejectedPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrganizationMainPage(orgUsername: _orgUsername)),
        );
      }
    } catch (e) {
      print("Error fetching organization details: $e");
      // Optionally, handle error and show a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
