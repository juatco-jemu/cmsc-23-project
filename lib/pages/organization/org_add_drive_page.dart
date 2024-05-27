import 'package:donation_system/model/model_drive.dart';
import 'package:donation_system/providers/provider_drive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDonationDrivePage extends StatefulWidget {
  final String orgUsername;

  const AddDonationDrivePage({super.key, required this.orgUsername});

  @override
  State<AddDonationDrivePage> createState() => _AddDonationDrivePageState();
}

class _AddDonationDrivePageState extends State<AddDonationDrivePage> {
  final _formKey = GlobalKey<FormState>();
  String? driveName;
  bool isOpen = false;
  String? driveDescription;
  String? driveLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Donation Drive'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              // Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Drive Name'),
                onSaved: (value) {
                  driveName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a drive name';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Status: ${isOpen ? 'Open' : 'Closed'}'),
                  Switch(
                    value: isOpen,
                    onChanged: (value) {
                      setState(() {
                        isOpen = value;
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (value) {
                  driveDescription = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                onSaved: (value) {
                  driveLocation = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    DonationDrive newDrive = DonationDrive(
                      driveID: 1,
                      orgUsername: widget.orgUsername,
                      driveName: driveName!,
                      driveStatus: isOpen ? 'Open' : 'Closed',
                      driveDescription: driveDescription!,
                      driveLocation: driveLocation!,
                      driveImgURL: [],
                      driveDonationIDList: []
                    );

                    context
                      .read<DonationDriveProvider>()
                      .addDonationDrive(newDrive);
                  }
                },
                child: Text('Submit'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
