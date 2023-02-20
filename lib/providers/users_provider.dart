import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthMethods _auth = AuthMethods();

  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    UserModel user = await _auth.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
