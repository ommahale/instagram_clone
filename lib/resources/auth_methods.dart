import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return UserModel.fromSnap(snap);
  }

  //sign up method
  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? profilePic,
  }) async {
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
        String imageURL = await StorageMethods()
            .storeImage('profilePics', profilePic!, false);
        //add user to database
        UserModel user = UserModel(
            email: email,
            bio: bio,
            uid: cred.user!.uid,
            username: username,
            photoURL: imageURL,
            followers: [],
            following: []);
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJSON());

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

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    late String res;
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = 'give all credentials';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
