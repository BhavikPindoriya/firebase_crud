import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_new_learn/widget/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  bool loading = false;
  File? _image; //this for uploaded file mate use thase
  final picker =
      ImagePicker(); // image picker no instanse lai lidho chhe ne aa apne gallary no asses karvama help karse

  firebase_storage.FirebaseStorage storage = firebase_storage
      .FirebaseStorage.instance; // this refrense for the firebase storage

  final databaseRef = FirebaseDatabase.instance.ref('Test');

  Future getImageGallery() async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print('No Image Picked..........');
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
              loading: loading,
              ontap: () async {
                setState(() {
                  loading = true;
                });

                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/foldername' + '1224');

                firebase_storage.UploadTask uploadTask =
                    ref.putFile(_image!.absolute);

                Future.value(uploadTask).then((value) {
                  var newUrl = ref.getDownloadURL(); // this image url

                  databaseRef.child('1').set({
                    // set the url in the real time database
                    'id': "1212",
                    'title': newUrl.toString()
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Fluttertoast.showToast(
                      msg: 'Uploaded',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.yellow,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Fluttertoast.showToast(
                      msg: error.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
