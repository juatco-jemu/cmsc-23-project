import 'package:camera/camera.dart';
import 'package:donation_system/components/addPhotos.dart';
import 'package:donation_system/components/appbar.dart';
import 'package:donation_system/components/qrCode.dart';
import 'package:donation_system/model/model_donation.dart';
import 'package:donation_system/model/model_donor.dart';
import 'package:donation_system/model/model_drive.dart';
import 'package:donation_system/providers/provider_donation.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DonatePage extends StatefulWidget {
  final Donor? donor;
  final DonationDrive drive;

  const DonatePage({super.key, required this.donor, required this.drive});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final List<String> _category = [
    "Food",
    "Clothes",
    "Cash",
    "Necessities",
  ];
  bool isPickup = true;
  DateTime dateTime = DateTime.now();
  late Size screen = MediaQuery.of(context).size;
  late TabController _tabController;
  List<XFile> images = [];
  List<CameraDescription> cameras = [];
  Set<String> selectedCategories = {};
  List<String> savedAddress = [];
  int? donationID;
  int? driveID;
  String? donorUsername;
  String? orgUsername;
  List<String> itemsToDonate = [];
  String? weight;
  String? mode; // Pickup or Drop-off
  DateTime? _selectedDate;
  String? selectedAddress;
  String? contactNumber;
  List<String>? imageURL; // Image as proof
  String? qrCode; // QR Code for Drop-off
  String? status; // Pending, Confirmed, Scheduled for Pick-up, Completed, Canceled

  @override
  void initState() {
    super.initState();
    _setDonationID();
    _tabController = TabController(length: 2, vsync: this);
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  Future<void> _setDonationID() async {
    int nextDonationID = await context.read<DonationsProvider>().getNextDonationID();
    setState(() {
      donationID = nextDonationID;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Donation Form',
      ),
      body: donationID == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  color: AppColors.backgroundYellow,
                  child: Column(
                    children: [
                      _buildForm()
                    ],
                  ),
                ),
            )
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              decoration: CustomWidgetDesigns.customContainer(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  formHeader("Donation Categories"),
                  donationCategory,
                  spacer(10),
                  weightForm,
                  spacer(30),
                ],
              ),
            ),
            spacer(20),
            Container(
              decoration: CustomWidgetDesigns.customContainer(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  formHeader("Pickup/Dropoff Details"),
                  pickupDropoff,
                  !isPickup ? generateQR() : Container(),
                ],
              ),
            ),
            spacer(20),
            const AddPhotos(),
            spacer(50),
            donateButton,
          ],
        ),
      )
    );
  }

  Widget spacer(double size) {
    return SizedBox(height: size);
  }

  Widget get donateButton => ElevatedButton(
    style: CustomWidgetDesigns.customSubmitButton(),
    onPressed: () async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        if (donationID != null) {
          Donation newDonation = Donation(
            donationID: donationID!, 
            driveID: widget.drive.driveID,
            donorUsername: widget.donor!.username!, 
            orgUsername: widget.drive.orgUsername, 
            itemsToDonate: itemsToDonate, 
            weight: weight!, 
            mode: isPickup ? "Pickup" : "Dropoff", 
            dateTime: dateTime, 
            selectedAddress: isPickup ? selectedAddress! : "", 
            contactNumber: widget.donor!.contactNumber!, 
            imageURL: [], 
            qrCode: "", 
            status: "Pending"
          );

          print(donationID);
          context.read<DonationsProvider>().addDonation(newDonation);
      
          if (mounted) Navigator.pop(context);

        } else {
          // Handle the case where driveID is null
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: Donation ID is null')),
          );
        }
      }
    },
    child: const Text("Submit Donation")
  
  );


  Widget generateQR() {
    return const Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: GenerateQRCode(),
      ),
    );
  }

  Widget get weightForm => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Weight(in kg): ",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            width: 130,
            // margin: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: CustomWidgetDesigns.customFormField("", "Enter weight").copyWith(
                border: const OutlineInputBorder(),
              ),
              onSaved: (value) => setState(() => weight = value),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter weight";
                }
                return null;
              },
            ),
          ),
        ],
  );

  Widget get pickupDropoff => Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        // height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.yellow01,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(isPickup ? Icons.wheelchair_pickup : Icons.delivery_dining,
                      size: 30, color: Colors.black),
                  Text(
                    isPickup ? "Pickup" : "Dropoff",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => FractionallySizedBox(
                              heightFactor: 0.6,
                              child: Column(
                                children: [
                                  hBar,
                                  Flexible(child: _buildPickupDropoff()),
                                ],
                              )),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          isScrollControlled: true,
                        );
                      },
                      child: const Text("Change")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date: ${DateFormat('MM/dd/yyyy').format(dateTime)}"),
                  Text(DateFormat('hh:mm a').format(dateTime)),
                ],
              ),
            ],
          ),
        ),
      );

  Widget get hBar => Container(
        width: 100,
        height: 4,
        margin: const EdgeInsets.only(top: 12, bottom: 12),
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(12),
        ),
      );

  Widget get donationCategory => Column(
    children: _category
      .map((e) => CheckboxListTile(
        title: Text(e),
        value: itemsToDonate.contains(e),
        onChanged: (bool? val) {
          setState(() {
            if (val == true) {
              itemsToDonate.add(e);
            } else {
              itemsToDonate.remove(e);
            }
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
      ))
      .toList(),
  );

  Widget formHeader(String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 0, 5),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAddressDropdown() {
    savedAddress = widget.donor!.addressList!;
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Select Address',
        border: OutlineInputBorder(),
      ),
      value: selectedAddress,
      onChanged: (String? newValue) {
        setState(() {
          selectedAddress = newValue;
        });
      },
      items: savedAddress.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an address';
        }
        return null;
      },
    );
  }

  Widget _buildPickupDropoff() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: "Pickup",
            ),
            Tab(
              text: "Dropoff",
            ),
          ],
        ),
        body: TabBarView(controller: _tabController, children: [
          Container(
            color: AppColors.backgroundYellow,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // spacer(30),
                formHeader("Pickup time: "),
                // DatePickerButton(),
                // spacer(20),
                // TimePickerDropdown(),
                changeDateTime(context),
                spacer(20),
                _buildAddressDropdown(),
                // TextField(
                //   decoration: CustomWidgetDesigns.customFormField("Address", "Enter address"),
                // ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration:
                      CustomWidgetDesigns.customFormField("Contact Number", "Enter contact number"),
                  onSaved: (value) => setState(() => contactNumber = value),
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  // You can add additional validation logic here
                  return null;
                },
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.backgroundYellow,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                formHeader("Dropoff time:"),
                changeDateTime(context),
              ],
            ),
          ),
        ]),
        bottomSheet: updateModeButton(context),
      ),
    );
  }

  Widget changeDateTime(context) {
    return StatefulBuilder(builder: (context, setStateTD) {
      return ElevatedButton(
        style: CustomWidgetDesigns.customSubmitButton(),
        onPressed: () async {
          await pickDateTime();
          setStateTD(
            () {},
          );
        },
        child: Text(DateFormat('MM/dd/yyyy hh:mm a').format(dateTime)),
      );
    });
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final newDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() => dateTime = newDateTime);

    print(dateTime);
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime(2100),
        initialDate: dateTime,
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );

  Widget updateModeButton(BuildContext context) {
    return Container(
      color: AppColors.appWhite,
      width: screen.width,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.yellow02),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: () {
            if (selectedAddress == null || selectedAddress!.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please select an address'),
                ),
              );
            } else {
              setState(() {
                isPickup = _tabController.index == 0;
              });
              Navigator.pop(context);
            }
          },
          child: const Text(
            "Update",
            style: TextStyle(color: AppColors.appWhite),
          ),
        ),
      ),
    );
  }

}