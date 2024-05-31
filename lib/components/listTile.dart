import 'package:flutter/material.dart';

ListTile customDonorListTile({
  required String title,
  required String subtitle,
}) {
  return ListTile(
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(subtitle),
    trailing: const Icon(
      Icons.favorite,
      color: Color.fromARGB(255, 234, 103, 168),
    ),
    onTap: () {},
  );
}

ListTile customDonationListTile({
  required String title,
  required String subtitle,
  required String trailing,
}) {
  return ListTile(
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(subtitle),
    trailing: statusIcon(trailing.toLowerCase()),
  );
}

Widget statusIcon(String status) {
  Color color;

  switch (status.toLowerCase()) {
    case 'confirmed':
      color = Colors.green;
      break;
    case 'pending':
      color = Colors.orange;
      break;
    case 'cancelled':
      color = Colors.grey;
      break;
    default:
      color = Colors.grey;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Text(
      status.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    ),
  );
}
