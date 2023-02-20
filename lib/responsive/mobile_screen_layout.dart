import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/providers/users_provider.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var username = "";
    // UserModel? user = Provider.of<UserProvider>(context).getUser;
    // if (user != null) {
    //   username = user.username;
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          username,
        ),
      ),
      body: TextButton(
        child: Text('SignOut'),
        onPressed: () async {
          await AuthMethods().signout();
        },
      ),
    );
  }
}
