import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class DonorGenerateQRPage extends StatefulWidget {
  const DonorGenerateQRPage({super.key});

  @override
  State<DonorGenerateQRPage> createState() => _DonorGenerateQRPageState();
}

class _DonorGenerateQRPageState extends State<DonorGenerateQRPage> {
  String? qrData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Generate QR Code"),
        ),
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              child: Text(
                "Generate QR Code",
              ),
              onPressed: () {
                setState(() {
                  qrData = DateTime.now().toString();
                });
              }),
          if (qrData != null) PrettyQrView.data(data: qrData!)
        ])));
  }
}
