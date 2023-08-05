import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService{

  static Future<UserCredential> signIn({required String email, required String password})async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }


  static Future<UserCredential> signUp({required String email,required String password})async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }

}