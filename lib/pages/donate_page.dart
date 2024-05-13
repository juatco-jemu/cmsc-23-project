import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final List<String> _category = [
    "Food",
    "Clothes",
    "Cash",
    "Necessities",
  ];

  Set<String> selectedCategories = {};

  final MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.favorite_rounded);
      }
      return const Icon(Icons.heart_broken_rounded);
    },
  );

  bool _currentStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donate"),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                donationCategory,
                pickupAndWeight,
                addressField,
                contactNoField,
                donateButton,
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get pickupAndWeight => Column(
        children: [
          const Text("Pickup?"),
          Container(
            margin: const EdgeInsets.all(20),
            child: Switch(
              thumbIcon: thumbIcon,
              value: _currentStatus,
              onChanged: (bool val) {
                setState(() {
                  _currentStatus = val;
                });
              },
            ),
          ),
          const Text("Weight:"),
          Container(
            margin: const EdgeInsets.all(20),
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter weight',
              ),
            ),
          ),
        ],
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

  Widget get addressField => Container(
        margin: const EdgeInsets.all(20),
        child: const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter address',
          ),
        ),
      );

  Widget get contactNoField => Container(
        margin: const EdgeInsets.all(20),
        child: const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter contact number',
          ),
        ),
      );

  Widget get donateButton => Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(
            // context, MaterialPageRoute(builder: (context) => const UserDetailsPage()));
          },
          child: const Text("Donate"),
        ),
      );
}
