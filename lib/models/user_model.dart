import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String username;
  final String photoURL;
  final String bio;
  final List followers;
  final List following;
  const UserModel({
    required this.email,
    required this.bio,
    required this.uid,
    required this.username,
    required this.photoURL,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJSON() {
    return {
      'username': username,
      'uid': uid,
      'email': email,
      'bio': bio,
      'followers': followers,
      'following': following,
      'photoURL': photoURL,
    };
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        email: snapshot['email'],
        bio: snapshot['bio'],
        uid: snapshot['uid'],
        username: snapshot['username'],
        photoURL: snapshot['photoURL'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }
}
