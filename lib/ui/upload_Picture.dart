import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadPictute extends StatefulWidget {
  const UploadPictute({super.key});

  @override
  State<UploadPictute> createState() => _UploadPictuteState();
}

class _UploadPictuteState extends State<UploadPictute> {
  String? imageUrl;
  final ImagePicker _imagePicker =
      ImagePicker(); // create the ImagePicker refrense
  bool isLoading = false;

  pickImage() async {
    XFile? res = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (res != null) {
      uploadtofirebase(File(res.path));
    }
  }

  uploadtofirebase(Image) async {
    setState(() {
      isLoading = true;
    });
    try {
      Reference sr = FirebaseStorage.instance.ref().child(
          'Images/${DateTime.now().microsecondsSinceEpoch}.png'); // this variable is create for the image upload
      await sr.putFile(Image).whenComplete(() {
        Fluttertoast.showToast(msg: "Image Uploaded to 🔥 Base");
      });

      imageUrl = await sr
          .getDownloadURL(); // get the image url and put the imageurl variable

      setState(() {});
    } catch (e) {
      print('error occured $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Picture'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            imageUrl == null
                ? const Icon(
                    Icons.person,
                    size: 200,
                    color: Colors.grey,
                  )
                : Center(
                    child: Image.network(
                      imageUrl!,
                      height: 70,
                    ),
                  ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton.icon(
                  onPressed: () {
                    pickImage();
                  },
                  icon: const Icon(Icons.image),
                  label: const Text(
                    'Upload Image',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            const SizedBox(
              height: 40,
            ),
            if (isLoading == true)
              const SpinKitThreeBounce(
                color: Colors.black,
                size: 20,
              )
          ],
        ),
      ),
    );
  }
}
