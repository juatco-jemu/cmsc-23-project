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
