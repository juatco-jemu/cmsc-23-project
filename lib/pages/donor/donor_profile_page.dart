import 'package:donation_system/pages/address_list_page.dart';
import 'package:donation_system/pages/donor/donor_profile_details_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../components/profileButton.dart';
import '../../model/model_donor.dart';

class DonorProfilePage extends StatefulWidget {
  final Donor? donor;

  const DonorProfilePage({super.key, required this.donor});

  @override
  State<DonorProfilePage> createState() => _DonorProfilePageState();
}

class _DonorProfilePageState extends State<DonorProfilePage> {
  late final extraHeight =
      MediaQuery.of(context).padding.top - kToolbarHeight; // contains the height of the status bar
  late final coverHeight = 150 - extraHeight;
  final double imageSize = 120;

  late Size screen = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    // Donor? donor = context.watch<DonorsProvider>().donorData;
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
              spacer,
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
        ProfileButton(title: "My Profile", route: DonorProfileDetailsPage(donor: widget.donor!)),
        ProfileButton(
            title: "My Addresses", route: AppAddressListPage(user: widget.donor, isDonor: true)),
        // ProfileButton(title: "My Favorites", route: "/"),
        ProfileButton(title: "My Donations", route: "/"),
        const ProfileButton(title: "Logout", route: "sign-out"),
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
        Text("Hello, ${widget.donor!.username}",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const Text(
          "Donor",
          style: TextStyle(fontSize: 20),
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
