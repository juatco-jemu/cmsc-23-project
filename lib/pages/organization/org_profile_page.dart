import 'package:donation_system/components/profileButton.dart';
import 'package:donation_system/model/model_organization.dart';
import 'package:donation_system/pages/organization/org_profile_details_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';
import '../address_list_page.dart';

class OrgProfilePage extends StatefulWidget {
  final Organization organization;

  const OrgProfilePage({super.key, required this.organization});

  @override
  State<OrgProfilePage> createState() => _OrgProfilePageState();
}

class _OrgProfilePageState extends State<OrgProfilePage> {
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
          height: screen.height,
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
    return Column(
      children: [
        ProfileButton(
            title: "Profile", route: OrgProfileDetailsPage(organization: widget.organization)),
        // ProfileButton(
        //     title: "Addresses",
        //     route: AppAddressListPage(user: widget.organization, isDonor: false)),
        const ProfileButton(title: "Logout", route: "sign-out")
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
        Text(widget.organization.orgName!,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Text(
          widget.organization.orgUsername!,
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
