import 'package:flutter/material.dart';

class OrgHomePage extends StatelessWidget {
  final String orgUsername;

  const OrgHomePage({Key? key, required this.orgUsername}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization Home'),
      ),
      body: Center(
        child: Text(
          'Home page, all donations will be shown here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
