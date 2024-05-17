import 'package:flutter/material.dart';

ListTile customDonorListTile({
  required String title,
  required String subtitle,
}) {
  return ListTile(
    title: Text(title),
    subtitle: Text(subtitle),
    trailing: const Icon(
      Icons.favorite,
      color: Color.fromARGB(255, 234, 103, 168),
    ),
    onTap: () {},
  );
}
