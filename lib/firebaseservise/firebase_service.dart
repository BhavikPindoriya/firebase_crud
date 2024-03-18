import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServisee {
  static Future<String?> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return email;
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }
}
