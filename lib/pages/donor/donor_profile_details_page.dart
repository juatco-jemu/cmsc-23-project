import 'package:donation_system/mock/mock_donor.dart';
import 'package:donation_system/model/model_donor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../theme/colors.dart';
import '../../theme/widget_designs.dart';

class DonorProfileDetailsPage extends StatefulWidget {
  const DonorProfileDetailsPage({super.key});

  @override
  State<DonorProfileDetailsPage> createState() => _DonorProfileDetailsPageState();
}

class _DonorProfileDetailsPageState extends State<DonorProfileDetailsPage> {
  late Size screen = MediaQuery.of(context).size;

  Donor donor = MockDonor.fetchDonor();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        // decoration: CustomWidgetDesigns.gradientBackground(),
        color: AppColors.backgroundYellow,
        child: Column(
          children: [
            spacer,
            _buildHeader(),
            // _buildUsername(),
            _buildBody(),
          ],
        ),
      ),
      bottomSheet: editProfileButton(context),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            backButton,
            Text("@${donor.username!}",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset('assets/images/cloud01.png', height: 80),
        )
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spacer,
          _inputLabel("First Name"),
          _formField(donor.firstName),
          _inputLabel("Last Name"),
          _formField(donor.lastName),
          _inputLabel("Email"),
          _formField(donor.email),
          _inputLabel("Contact Number"),
          _formField(donor.contactNumber),
          spacer,
        ],
      ),
    );
  }

  Widget _formField(data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Material(
        elevation: 2,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          readOnly: true,
          decoration:
              CustomWidgetDesigns.customFormField(data, "Enter your new ${data.toLowerCase()}"),
          // onSaved: (value) => setState(() => username = value),
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return "Please enter your username";
          //   }
          //   return null;
          // },
        ),
      ),
    );
  }

  Widget _inputLabel(label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget editProfileButton(context) {
    return Container(
      color: AppColors.backgroundYellow,
      width: screen.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.yellow02),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: () {},
          child: const Text(
            "Edit Profile",
            style: TextStyle(color: AppColors.appWhite),
          ),
        ),
      ),
    );
  }

  Widget get backButton => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
            onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
      );

  Widget get spacer => const SizedBox(height: 40);
}
