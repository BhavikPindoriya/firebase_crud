import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_new_learn/ui/splase_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // firebase name is already exists this type of error then the this line to solve the error
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCPNYSWIpf4QUnjy6elIJyILka5mcvxO9E',
      appId: '1:766965983832:android:1878ccfe1bbd4f303b382d',
      messagingSenderId: '766965983832',
      projectId: 'fir-new-learn-86751',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const SplashScreen(),
    );
  }
}
