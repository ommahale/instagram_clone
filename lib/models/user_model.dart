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
}
