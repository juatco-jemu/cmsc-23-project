import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonateForm extends StatefulWidget {
  const DonateForm({super.key});

  @override
  State<DonateForm> createState() => DonateFormState();
}

class DonateFormState extends State<DonateForm> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _category = [
    "Food",
    "Clothes",
    "Cash",
    "Necessities",
  ];

  Set<String> selectedCategories = {};

  final WidgetStateProperty<Icon?> thumbIcon = WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.favorite_rounded);
      }
      return const Icon(Icons.heart_broken_rounded);
    },
  );

  bool isPickup = true;
  DateTime dateTime = DateTime.now();
  late Size screen = MediaQuery.of(context).size;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Align(
      alignment: Alignment.center,
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
                  !isPickup ? generateQR : Container(),
                ],
              ),
            ),
            spacer(50),
          ],
        ),
      ),
    ));
  }

  Widget spacer(double size) {
    return SizedBox(height: size);
  }

  Widget get generateQR => Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TextButton(
            // style: ButtonStyle(
            //   minimumSize: WidgetStateProperty.all(Size(screen.width, 40)),
            //   backgroundColor: WidgetStateProperty.all(AppColors.yellow02),
            //   shape: WidgetStateProperty.all(
            //     RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            // ),
            onPressed: () {
              setState(() {
                if (_tabController.index == 0) {
                  isPickup = true;
                } else {
                  isPickup = false;
                }
              });

              Navigator.pop(context);
            },
            child: const Text(
              "Generate QR Code",
              style: TextStyle(color: AppColors.yellow03),
            ),
          ),
        ),
      );

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
                  value: selectedCategories.contains(e),
                  onChanged: (bool? val) {
                    setState(() {
                      if (val == true) {
                        selectedCategories.add(e);
                      } else {
                        selectedCategories.remove(e);
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
                changeDateTime(context),
                spacer(20),
                TextField(
                  decoration: CustomWidgetDesigns.customFormField("Address", "Enter address"),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration:
                      CustomWidgetDesigns.customFormField("Contact Number", "Enter contact number"),
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

  Widget updateModeButton(context) {
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
            setState(() {
              if (_tabController.index == 0) {
                isPickup = true;
              } else {
                isPickup = false;
              }
            });

            Navigator.pop(context);
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
