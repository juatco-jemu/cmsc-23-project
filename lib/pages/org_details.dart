import 'package:donation_system/model/model_organization.dart';
import 'package:donation_system/pages/donate_page.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

import '../components/appbar.dart';

class OrgDetailsPage extends StatelessWidget {
  final Organization org;
  const OrgDetailsPage({super.key, required this.org});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Organization Details",
      ),
      body: Container(
        decoration: CustomWidgetDesigns.gradientBackground(),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                orgName(org.name),
                orgAbout(org.about),
                donateButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orgName(name) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text(
        name,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget orgAbout(about) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text(
        about,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Widget donateButton(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DonatePage()));
        },
        child: const Text("Donate"),
      ),
    );
  }
}
