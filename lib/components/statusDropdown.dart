import 'package:flutter/material.dart';

class DropdownStatusSelector extends StatelessWidget {
  final String selectedValue;
  final List<String> options;
  final ValueChanged<String?>? onChanged;

  const DropdownStatusSelector({
    Key? key,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = selectedValue == 'Open' ? Colors.green : Colors.grey;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: onChanged,
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
        dropdownColor: Colors.grey,
        underline: Container(),
      ),
    );
  }
}
