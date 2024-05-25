import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class DonateForm extends StatefulWidget {
  const DonateForm({super.key});

  @override
  State<DonateForm> createState() => _DonateFormState();
}

class _DonateFormState extends State<DonateForm> {
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

  bool _currentStatus = false;
  late Size screen = MediaQuery.of(context).size;
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
        height: 60,
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.wheelchair_pickup),
            const Text(
              "Pickup",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => FractionallySizedBox(
                        heightFactor: 0.75,
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
    return Scaffold(
      bottomSheet: donateButton(context),
    );
  }

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
          onPressed: () {},
          child: const Text(
            "Update",
            style: TextStyle(color: AppColors.appWhite),
          ),
        ),
      ),
    );
  }
}
