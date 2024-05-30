import 'dart:typed_data';

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
            controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates, returnImage: true),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                print("Barcode: ${barcode.rawValue}");
              }

              if (image != null) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(barcodes.first.rawValue ?? "No QR Code Found"),
                        content: Image.memory(image),
                      );
                    });
              }
            },
          ),
        ));
  }
}
