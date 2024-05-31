import 'package:donation_system/theme/colors.dart';
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
    return TextButton(
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
                    child: (qrData != null) ? PrettyQrView.data(data: qrData!) : Container(),
                  ));
        });
  }
}
