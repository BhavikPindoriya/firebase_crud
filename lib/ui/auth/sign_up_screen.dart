import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_new_learn/ui/auth/login_screen.dart';
import 'package:firebase_new_learn/widget/Text_field.dart';
import 'package:firebase_new_learn/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailc = TextEditingController();
  TextEditingController passwordc = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailc.dispose();
    passwordc.dispose();
  }

  void Signup() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailc.text.toString(), password: passwordc.text.toString())
        .then((value) {
      setState(() {
        Fluttertoast.showToast(msg: "Welcome", backgroundColor: Colors.amber);
        loading = false;
      });
    }).onError((error, stackTrace) async {
      await Fluttertoast.showToast(
        msg: error.toString(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //app bar back arrow not showing
        title: const Text('Sign up'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFieldd(
                    keyboard: TextInputType.emailAddress,
                    hinttext: "Email",
                    helpertext: "",
                    controller: emailc,
                    icon: const Icon(Icons.alternate_email),
                    obscure: false,
                    validatee: (value) {
                      if (value!.isEmpty ||
                          !value.contains("@") ||
                          !value.contains(".com")) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldd(
                    keyboard: TextInputType.number,
                    hinttext: "Password",
                    controller: passwordc,
                    icon: const Icon(Icons.lock_open),
                    obscure: true,
                    helpertext: '',
                    validatee: (value) {
                      if (value!.isEmpty) {
                        return "Enter the password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Roundbutton(
                    loading: loading,
                    Title: "Sign up",
                    ontap: () {
                      if (_formkey.currentState!.validate()) {
                        Signup();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account ?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
