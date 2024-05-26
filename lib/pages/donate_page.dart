import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../theme/colors.dart';

class DonateForm extends StatefulWidget {
  const DonateForm({super.key});

  @override
  State<DonateForm> createState() => _DonateFormState();
}

class _DonateFormState extends State<DonateForm> with SingleTickerProviderStateMixin {
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
      child: Container(
        decoration: CustomWidgetDesigns.customContainer(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            formHeader("Donation Categories"),
            donationCategory,
            spacer(10),
            weightForm,
            spacer(30),
            pickupDropoff,
            spacer(50),
            // addressField,
            // contactNoField,
            const SizedBox(height: 20)
          ],
        ),
      ),
    ));
  }

  Widget spacer(double size) {
    return SizedBox(height: size);
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
            child: TextField(
                decoration: CustomWidgetDesigns.customFormField("", "Enter weight").copyWith(
              border: const OutlineInputBorder(),
            )),
          ),
        ],
      );

  Widget get pickupDropoff => Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        // height: 60,
        color: Colors.grey[200],
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
              Text("Date: ${dateTime.year}/${dateTime.month}/${dateTime.day}"),
              Text("Time: ${dateTime.hour}:${dateTime.minute}")
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
      child: StatefulBuilder(builder: (context, setStateDT) {
        return Scaffold(
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
          body: TabBarView(children: [
            Container(
              color: AppColors.backgroundYellow,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  spacer(30),
                  ElevatedButton(
                      style: CustomWidgetDesigns.customSubmitButton(),
                      onPressed: () async {
                        await pickDateTime();
                        setStateDT(() {});
                      },
                      child: Text(
                          "${dateTime.year}/${dateTime.month}/${dateTime.day} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}")),
                  spacer(20),
                  TextField(
                    decoration: CustomWidgetDesigns.customFormField("Address", "Enter address"),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: CustomWidgetDesigns.customFormField(
                        "Contact Number", "Enter contact number"),
                  ),
                ],
              ),
            ),
            Container(
              color: AppColors.backgroundYellow,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  spacer(30),
                  ElevatedButton(
                      style: CustomWidgetDesigns.customSubmitButton(),
                      onPressed: () async {
                        await pickDateTime();
                        setStateDT(() {});
                      },
                      child: Text(
                          "${dateTime.year}/${dateTime.month}/${dateTime.day} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}")),
                  spacer(20),
                  TextField(
                    decoration: CustomWidgetDesigns.customFormField(
                        "Contact Number", "Enter contact number"),
                  ),
                ],
              ),
            ),
          ]),
          bottomSheet: donateButton(context),
        );
      }),
    );
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

  Widget donateButton(context) {
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
