import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_new_learn/ui/auth/login_with_phone_number.dart';
import 'package:firebase_new_learn/ui/auth/sign_up_screen.dart';
import 'package:firebase_new_learn/ui/posts/post_screen.dart';
import 'package:firebase_new_learn/widget/Text_field.dart';
import 'package:firebase_new_learn/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailc = TextEditingController();
  TextEditingController passwordc = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailc.dispose();
    passwordc.dispose();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailc.text.toString(), password: passwordc.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(
        msg: value.user!.email.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amber,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(),
          ));
    }).onError((error, stackTrace) async {
      setState(() {
        loading = false;
      });
      await Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //user back the login page to mobile screen
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, //app bar back arrow not showing
          title: const Text('Login'),
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
                      keybord: TextInputType.emailAddress,
                      hinttext: "Email",
                      helpertext: "",
                      controller: emailc,
                      icon: const Icon(Icons.alternate_email),
                      obscure: false,
                      validatee: (value) {
                        if (value!.isEmpty ||
                            !value.contains("@") ||
                            !value.contains(".com")) {
                          return 'Please enter the Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldd(
                      keybord: TextInputType.number,
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
                    SizedBox(
                      height: 20,
                    ),
                    Roundbutton(
                      loading: loading,
                      Title: "Submit",
                      ontap: () {
                        if (_formkey.currentState!.validate()) {
                          login();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account ?"),
                        TextButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                await MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ));
                          },
                          child: const Text('Sign up'),
                        ),

                        // ignore: avoid_unnecessary_containers
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        // ignore: avoid_print
                        print("Clicked the phone number");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LoginWithPhoneNumber(),
                            ));
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black)),
                        child: const Center(
                          child: Text("Login With Phone number"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
