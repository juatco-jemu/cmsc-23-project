import 'package:donation_system/mock/mock_organization.dart';
import 'package:donation_system/model/model_organization.dart';
import 'package:donation_system/pages/signin_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../components/profileButton.dart';
import '../../mock/mock_donor.dart';
import '../../model/model_donor.dart';

class OrgProfilePage extends StatefulWidget {
  const OrgProfilePage({super.key});

  @override
  State<OrgProfilePage> createState() => _OrgProfilePageState();
}

class _OrgProfilePageState extends State<OrgProfilePage> {
  Organization org = MockOrganization.fetchOne();
  late final extraHeight =
      MediaQuery.of(context).padding.top - kToolbarHeight; // contains the height of the status bar
  late final coverHeight = 150 - extraHeight;
  final double imageSize = 120;

  late Size screen = MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(title: "${donor.name}'s Profile Page"),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.backgroundYellow,
          // decoration: CustomWidgetDesigns.gradientBackground(),
          // height: screen.height - extraHeight,
          child: Column(
            children: [
              _buildTop(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return const Column(
      children: [
        ProfileButton(title: "My Profile", route: "/"),
        ProfileButton(title: "My Addresses", route: "/"),
        ProfileButton(title: "Logout", route: "sign-out"),
      ],
    );
  }

  Widget _buildTop() {
    return Column(
      children: [
        Stack(clipBehavior: Clip.none, alignment: Alignment.bottomCenter, children: [
          profileHeaderBackground,
          Positioned(top: coverHeight - (imageSize / 2), child: profileImage),
        ]),
        spacer,
        spacer,
        Text(org.orgName!, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Text(
          org.orgUsername!,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget get profileHeaderBackground => Container(
        height: 180,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/signup_org_bg.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
      );

  Widget get profileImage => SizedBox(
        width: imageSize,
        height: imageSize,
        child: Card(
          color: AppColors.appWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );

  Widget get spacer => const SizedBox(height: 30);
}