import 'dart:typed_data';

import 'package:donation_system/theme/colors.dart';
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
  late Size screen = MediaQuery.of(context).size;
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
          child: Column(
            children: [
              SizedBox(
                width: screen.width,
                height: screen.width,
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.memory(image),
                                  const Text(
                                      "Successfully Confirmed donation drop-off! Tap outside this dialog to close.",
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("Scan the QR Code to confirm the drop-off donation.",
                    style: TextStyle(fontSize: 20)),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel",
                      style: TextStyle(color: AppColors.yellow03, fontSize: 20)))
            ],
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
