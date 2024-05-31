import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/appbar.dart';

class OrgScanQRCodePage extends StatefulWidget {
  const OrgScanQRCodePage({super.key});

  @override
  State<OrgScanQRCodePage> createState() => _OrgScanQRCodePageState();
}

class _OrgScanQRCodePageState extends State<OrgScanQRCodePage> {
  @override
  void initState() {
    super.initState();
    requestCameraPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Scan QR Code",
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.only(bottom: 300),
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
                          content: Column(
                            children: [
                              Image.memory(image),
                              const Text("Successfully scanned QR Code!"),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ));
  }

  void requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
      if (!status.isGranted) {
        // The user did not grant the permission
        return;
      }
    }

    // The camera permission was granted
    // You can now access the camera
  }
}
