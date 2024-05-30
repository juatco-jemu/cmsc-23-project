import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class OrgScanQRCodePage extends StatefulWidget {
  const OrgScanQRCodePage({super.key});

  @override
  State<OrgScanQRCodePage> createState() => _OrgScanQRCodePageState();
}

class _OrgScanQRCodePageState extends State<OrgScanQRCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Scan QR Code"),
        ),
        body: Center(
          child: MobileScanner(
            onDetect: (capture) {},
          ),
        ));
  }
}
