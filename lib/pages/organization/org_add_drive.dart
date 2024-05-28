import 'package:donation_system/components/appbar.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/model_donation.dart';
import '../../theme/widget_designs.dart';

class AddDrivePage extends StatefulWidget {
  const AddDrivePage({super.key});

  @override
  State<AddDrivePage> createState() => _AddDrivePageState();
}

class _AddDrivePageState extends State<AddDrivePage> {
  final _formKey = GlobalKey<FormState>();
  String? driveName;
  String? driveStatus;
  String? driveDescription;
  String? driveLocation;
  List<String>? driveImgURL;
  List<Donation>? driveDonationList = [];

  late Size screen = MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Add Donation Drive',
        ),
        body: SingleChildScrollView(
          child: Container(
              height: screen.height,
              color: AppColors.backgroundYellow,
              child: Column(
                children: [
                  _buildForm(),
                ],
              )),
        ));
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacer,
            header,
            _inputLabel("What is the name of your event?"),
            driveNameField, // added this as a new field required
            _inputLabel("Enter brief description about your event"),
            driveDescriptionField, // same as above
            _inputLabel("Where will the event take place?"),
            driveLocationField,
            _inputLabel("Is the event ongoing?"),
            driveStatusSwitch,
            submitButton
          ],
        ),
      ),
    );
  }

  Widget get header => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "The first step to a successful donation drive is to create one! Fill out the form below to get started :)",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );

  Widget _inputLabel(label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // added this to get the first name
  Widget get driveNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration: CustomWidgetDesigns.customFormField("Drive Name", ""),
            onSaved: (value) => setState(() => driveName = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your drive name";
              }
              return null;
            },
          ),
        ),
      );
  // added this to get the last name
  Widget get driveDescriptionField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            textAlign: TextAlign.start,
            maxLines: 4,
            decoration: CustomWidgetDesigns.customFormField("Description", "")
                .copyWith(alignLabelWithHint: true),
            onSaved: (value) => setState(() => driveDescription = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter brief description about your event";
              }
              return null;
            },
          ),
        ),
      );

  Widget get driveStatusSwitch => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonFormField<String>(
            decoration: CustomWidgetDesigns.customFormField("Status", "Is the event ongoing?"),
            items: <String>['Open', 'Closed']
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                driveStatus = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select the status of the event";
              }
              return null;
            },
          ),
        ),
      );

  Widget get driveLocationField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration:
                CustomWidgetDesigns.customFormField("Address", "Where will the event take place?"),
            onSaved: (value) => setState(() => driveLocation = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your address";
              }
              return null;
            },
          ),
        ),
      );

  Widget get submitButton => ElevatedButton(
      style: CustomWidgetDesigns.customSubmitButton(),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          // await context.read<UserAuthProvider>().authService.signUpDonor(firstName!, lastName!,
          //     username!, email!, addressList, contactNumber, donationList, password!);

          // check if the widget hasn't been disposed of after an asynchronous action
          if (mounted) Navigator.pop(context);
        }
      },
      child: const Text("Create Event"));

  Widget get spacer => const SizedBox(height: 30);
}
