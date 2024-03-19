import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_new_learn/ui/auth/login_screen.dart';
import 'package:firebase_new_learn/ui/firestore/firestore_list_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 3),
          // () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             const PostScreen()))); // this is the post file
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const FireStoreScreen()))); // this is the uncomment use the FireStoreScreen database use
      // () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             const UploadPictute()))); // upload the images in firestore
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())));
    }
  }
}
