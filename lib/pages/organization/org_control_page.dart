import 'package:donation_system/pages/organization/org_home_page.dart';
import 'package:donation_system/pages/organization/org_pending_page.dart';
import 'package:donation_system/providers/provider_organizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationControlPage extends StatefulWidget {
  final String userEmail;

  const OrganizationControlPage({Key? key, required this.userEmail}) : super(key: key);

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
      String? orgUsername = await context.read<OrganizationsProvider>().getOrganizationUsername(widget.userEmail);
      String? orgStatus = await context.read<OrganizationsProvider>().getOrganizationStatus(orgUsername!);
      
      setState(() {
        _orgUsername = orgUsername;
        _orgStatus = orgStatus!;
      });

      if (_orgStatus == "Pending") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PendingOrgPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrganizationHomePage(orgUsername: _orgUsername)),
        );
      }
    } catch (e) {
      print("Error fetching organization details: $e");
      // Optionally, handle error and show a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
