import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_new_learn/ui/auth/login_screen.dart';
import 'package:firebase_new_learn/ui/firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final EditController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('users').snapshots();

  final ref = FirebaseFirestore.instance
      .collection('users'); //Without snapshots collection add

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              }).onError((error, stackTrace) {
                Fluttertoast.showToast(msg: error.toString());
              });
            },
            icon: const Icon(Icons.login_outlined),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        title: const Center(child: Text("FireStore")),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddFirestoreData(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: firestore,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) return const Text("Some error");

              return Expanded(
                  child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      // ref
                      //     .doc(snapshot.data!.docs[index]['id'].toString())
                      //     .update({'title': 'Hello Bhavik'}).then((value) {
                      //   Fluttertoast.showToast(
                      //     msg: "Post Updated",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.BOTTOM,
                      //     timeInSecForIosWeb: 1,
                      //     backgroundColor: Colors.amber,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0,
                      //   );
                      // }).onError((error, stackTrace) {
                      //   Fluttertoast.showToast(
                      //     msg: error.toString(),
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.BOTTOM,
                      //     timeInSecForIosWeb: 1,
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0,
                      //   );
                      // });

                      ref
                          .doc(snapshot.data!.docs[index]['id'].toString())
                          .delete();
                    },
                    title: Text(snapshot.data!.docs[index]['title'].toString()),
                    subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                  );
                },
              ));
            },
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    EditController.text =
        title; // title ni je value hase te automatic textEditing Controller ma avi jase
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update'),
          content: Container(
            child: TextField(
              controller: EditController,
              decoration: const InputDecoration(hintText: 'Edit'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
