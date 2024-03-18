import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_new_learn/ui/auth/login_screen.dart';
import 'package:firebase_new_learn/ui/posts/add_post.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance
      .ref('Test'); //check the firebase ref and you type ref is same or not

  final searchFilter = TextEditingController();
  final EditController = TextEditingController();

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
        title: const Center(child: Text("Post Details")),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPostScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchFilter,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  hintText: "search",
                  border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('Title').value.toString();

                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child('Title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialog(title,
                                    snapshot.child('id').value.toString());
                              },
                              leading: const Icon(Icons.edit),
                              title: const Text("Edit"),
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                ref
                                    .child(
                                        snapshot.child('id').value.toString())
                                    .remove();
                              },
                              leading: Icon(Icons.delete),
                              title: Text("Delete"),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (title.toLowerCase().contains(
                      searchFilter.text.toLowerCase().toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child('Title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  } else {
                    return Container();
                  }
                }),
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
                ref.child(id).update(
                    {'Title': EditController.text.toLowerCase()}).then((value) {
                  Fluttertoast.showToast(
                    msg: 'Post Updated',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.yellow,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }).onError((error, stackTrace) {
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

//------------------------------ Stream Builder ---------------------------------------

// Expanded(
//   child: StreamBuilder(
//     stream: ref.onValue,
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) {
//         return const CircularProgressIndicator();
//       } else {
//         Map<dynamic, dynamic> map =
//             snapshot.data!.snapshot.value as dynamic;
//         List<dynamic> list = [];
//         list.clear();
//         list = map.values.toList();

//         return ListView.builder(
//           itemCount: snapshot.data!.snapshot.children
//               .length, // this is length of the firebase children
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(list[index]['Title']),
//               subtitle: Text(list[index]['id']),
//             );
//           },
//         );
//       }
//     },
//   ),
// ),
