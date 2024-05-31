import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';

import '../theme/widget_designs.dart';

class AddPhotos extends StatefulWidget {
  const AddPhotos({super.key});

  @override
  State<AddPhotos> createState() => _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> images = [];
  int _current = 0;

  late Size screen = MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    List<bool> _isZoomable = List.filled(images.length, false);
    return buildAddPhotos();
  }

  Widget formHeader(String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 0, 5),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget spacer(double height) {
    return SizedBox(height: height);
  }

  Widget buildAddPhotos() {
    return SingleChildScrollView(
      child: Container(
        decoration: CustomWidgetDesigns.customContainer(),
        width: screen.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            formHeader("Add Photos"),
            spacer(20),
            images.isEmpty
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: _takePhoto,
                          icon: const Icon(Icons.camera, size: 50),
                        ),
                        IconButton(
                          onPressed: () async {
                            final List<XFile>? photos = await _picker.pickMultiImage();
                            if (photos != null) {
                              setState(() {
                                images.addAll(photos);
                              });
                            }
                          },
                          icon: const Icon(Icons.photo_library, size: 50),
                        ),
                      ],
                    ),
                  )
                : Wrap(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 400.0, // Adjust this value as needed
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                        items: images.map((image) {
                          int index = images.indexOf(image);
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return PhotoView(
                                        backgroundDecoration:
                                            const BoxDecoration(color: Colors.transparent),
                                        imageProvider: FileImage(File(image.path)),
                                      );
                                    },
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Image.file(
                                        File(image.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white.withAlpha(
                                                200), // Optional: use this line if you want the circle to have a background color
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              deletePhoto(index);
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: images.map((url) {
                          int index = images.indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                      TextButton(
                        onPressed: _addMorePhotos,
                        child: const Text("Add more photos"),
                      ),
                    ],
                  ),
            spacer(20),
          ],
        ),
      ),
    );
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      var result = await Permission.camera.request();
      if (!result.isGranted) {
        // The user did not grant the permission
        return;
      }
    }
    // The user granted the permission, you can use the camera now
  }

  Future<void> _addMorePhotos() async {
    final String? source = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add more photos'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'gallery');
              },
              child: const Text('Choose from gallery'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'camera');
              },
              child: const Text('Take a photo'),
            ),
          ],
        );
      },
    );

    if (source != null) {
      if (source == 'camera') {
        await _takePhoto();
      } else {
        final List<XFile>? photos = await _picker.pickMultiImage();
        if (photos != null) {
          setState(() {
            images.addAll(photos);
          });
        }
      }
    }
  }

  void deletePhoto(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  Future<void> _takePhoto() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        images.add(photo);
      });
    }
  }
}
