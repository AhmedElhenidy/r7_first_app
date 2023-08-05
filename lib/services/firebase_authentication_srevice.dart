import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService{

  static Future<UserCredential> signIn({required String email, required String password})async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }


  static Future<UserCredential> signUp({required String email,required String password,
  required String name,required String phone})async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseFirestore.instance.collection('users').doc(credential.user?.uid)
    .set({
      "id":credential.user?.uid,
      "name":name,
      "mail":email,
      "phone":phone,
      "image":"",
    });
    return credential;
  }

}