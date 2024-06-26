import 'package:donation_system/providers/provider_auth.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class ProfileButton extends StatefulWidget {
  final String title;
  final dynamic route;
  const ProfileButton({required this.title, required this.route, super.key});

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: CustomWidgetDesigns.customTileContainer().copyWith(
        color: AppColors.yellow01,
      ),
      child: ListTile(
        onTap: () {
          if (widget.route == 'sign-out') {
            context.read<UserAuthProvider>().signOut();
            Navigator.pushReplacementNamed(context, "/");
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget.route));
          }
        },
        title: Text(widget.title),
        trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.darkYellow01),
      ),
    );
  }
}
