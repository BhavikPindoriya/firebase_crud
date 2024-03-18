import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_new_learn/ui/posts/post_screen.dart';
import 'package:firebase_new_learn/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyCode extends StatefulWidget {
  VerifyCode({super.key, required this.verificationId});

  final String verificationId;

  @override
  State<VerifyCode> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<VerifyCode> {
  final verificationcallcontroller = TextEditingController();

  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verify'),
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
              controller: verificationcallcontroller,
              decoration: InputDecoration(hintText: "6 digit code"),
            ),
            const SizedBox(
              height: 80,
            ),
            Roundbutton(
                Title: "Verify",
                loading: loading,
                ontap: () async {
                  setState(() {
                    loading = true;
                  });

                  final crendital = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verificationcallcontroller.text.toString());

                  try {
                    await auth.signInWithCredential(crendital);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PostScreen()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });

                    Fluttertoast.showToast(
                      msg: e.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
