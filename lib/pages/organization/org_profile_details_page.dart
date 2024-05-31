import 'package:donation_system/model/model_organization.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/widget_designs.dart';

class OrgProfileDetailsPage extends StatefulWidget {
  final Organization organization;

  const OrgProfileDetailsPage({super.key, required this.organization});

  @override
  State<OrgProfileDetailsPage> createState() => _OrgProfileDetailsPageState();
}

class _OrgProfileDetailsPageState extends State<OrgProfileDetailsPage> {
  late Size screen = MediaQuery.of(context).size;

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

  Widget _buildUsername() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("@${widget.organization.orgUsername!}",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Container(
          margin: const EdgeInsets.only(left: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: widget.organization.orgStatus == "Approved" ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(widget.organization.orgStatus!.toUpperCase(),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ],
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
            Text("@${widget.organization.orgUsername!}",
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
          _inputLabel("Organization Name"),
          _formField(widget.organization.orgName),
          _inputLabel("Organization Email"),
          _formField(widget.organization.orgEmail),
          _inputLabel("Organization Contact Number"),
          _formField((widget.organization.orgContactNumber == "")
              ? "Not provided"
              : widget.organization.orgContactNumber!),
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
          enabled: false,
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
