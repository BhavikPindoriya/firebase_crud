import 'dart:io';

import 'package:firebase_new_learn/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image; //this for uploaded file mate use thase
  final picker =
      ImagePicker(); // image picker no instanse lai lidho chhe ne aa apne gallary no asses karvama help karse

  Future getImageGallery() async {
    // ignore: non_constant_identifier_names
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print('No Image Picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Images'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : const Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            const SizedBox(
              height: 39,
            ),
            Roundbutton(
              Title: 'Upload',
              ontap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
