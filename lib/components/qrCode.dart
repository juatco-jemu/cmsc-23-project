import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  State<GenerateQRCode> createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  String? qrData;
  @override
  Widget build(BuildContext context) {
    return qrData != null
        ? TextButton(
            child: const Text(
              "View QR Code",
              style: TextStyle(color: AppColors.yellow03),
            ),
            onPressed: () {
              showDialog(
                  context: (context),
                  builder: (context) => Dialog(
                        child: qrDialog(qrData),
                      ));
            })
        : TextButton(
            child: const Text(
              "Generate QR Code",
              style: TextStyle(color: AppColors.yellow03),
            ),
            onPressed: () {
              setState(() {
                qrData = DateTime.now().toString();
              });
              showDialog(
                  context: (context),
                  builder: (context) => Dialog(
                        child: qrDialog(qrData),
                      ));
              
            });
  }

  Widget qrDialog(qrData) {
    return Container(
        width: 150,
        padding: const EdgeInsets.all(20),
        decoration: CustomWidgetDesigns.customContainer(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrettyQrView.data(data: qrData!),
            spacer(20),
            const Text("Here is your QR Code. Tap anywhere outside the box to close this dialog.",
                style: TextStyle(fontSize: 20)),
          ],
        ));
  }

  Widget spacer(double height) {
    return SizedBox(height: height);
  }
}
