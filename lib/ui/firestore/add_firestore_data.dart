import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_new_learn/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFirestoreData extends StatefulWidget {
  const AddFirestoreData({super.key});

  @override
  State<AddFirestoreData> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddFirestoreData> {
  final postController = TextEditingController();
  bool loading = false;
  final firestore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Add FireStore Data"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'What is your mind?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Roundbutton(
              Title: 'Add',
              loading: loading,
              ontap: () {
                setState(() {
                  loading = true;
                });
                String id = DateTime.now().microsecondsSinceEpoch.toString();

                firestore.doc(id).set({
                  'title': postController.text.toString(),
                  'id': id
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Fluttertoast.showToast(
                    msg: 'Post added',
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
              },
            )
          ],
        ),
      ),
    );
  }
}
