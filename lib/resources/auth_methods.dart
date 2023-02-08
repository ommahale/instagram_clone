import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign up method
  Future<String> signupUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List? profilePic}) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          profilePic != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //add user to database
        await _firestore.collection("users").doc(cred.user!.uid).set({
          "username": username,
          "uid": cred.user!.uid,
          "email": email,
          "bio": bio,
          "followers": [],
          "following": [],
        });
        // await _firestore.collection("users").add({
        //   "username": username,
        //   "uid": cred.user!.uid,
        //   "email": email,
        //   "bio": bio,
        //   "followers": [],
        //   "following": [],
        // });
        res = "success";
      }
      return res;
    } catch (e) {
      res = e.toString();
      return res;
    }
  }
}
