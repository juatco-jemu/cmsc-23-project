import 'package:flutter/material.dart';

class DonateFormPage extends StatelessWidget {
  const DonateFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Form'),
      ),
      body: Center(
        child: Text(
          'Donate Form Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
