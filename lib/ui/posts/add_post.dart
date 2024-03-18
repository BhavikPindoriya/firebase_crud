import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_new_learn/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance
      .ref('Test'); //add the data in realTimedatabase in firebase
  //create the table
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Add Post"),
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

                databaseRef.child(id).set({
                  'Title': postController.text.toString(),
                  'id': id,
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Fluttertoast.showToast(
                    msg: "Post Added",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.amber,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }).onError((error, stackTrace) {
                  loading = false;
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
