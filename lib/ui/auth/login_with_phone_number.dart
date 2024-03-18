import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_new_learn/ui/auth/verify_code.dart';
import 'package:firebase_new_learn/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phonenumberController = TextEditingController();

  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login With Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: phonenumberController,
              decoration: InputDecoration(hintText: "+1 234 565 489"),
            ),
            const SizedBox(
              height: 80,
            ),
            Roundbutton(
              Title: "Logn",
              loading: loading,
              ontap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                    phoneNumber: phonenumberController.text,
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) async {
                      await Fluttertoast.showToast(
                        msg: e.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      setState(() {
                        loading = false;
                      });
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyCode(
                              verificationId: verificationId,
                            ),
                          ));
                      setState(() {
                        loading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) async {
                      await Fluttertoast.showToast(
                        msg: e.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      setState(() {
                        loading = false;
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
