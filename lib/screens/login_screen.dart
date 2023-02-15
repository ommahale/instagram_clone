import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logInUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().logInUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      _isLoading = false;
    });
    if (res != "success" && mounted) {
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //instagram logo svg
                SvgPicture.asset(
                  'assets/logo.svg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 64,
                )
                //text area username
                ,
                CustomTextField(
                    iconData: Icons.mail,
                    hintText: 'Enter your email id',
                    isPass: false,
                    textEditingController: _emailController,
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                //text area password
                CustomTextField(
                    iconData: Icons.lock,
                    hintText: 'Enter your password',
                    isPass: true,
                    textEditingController: _passwordController,
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                //button login
                ElevatedButton(
                  // onPressed: () {},
                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: const [
                  //     Text(
                  //       'Log in',
                  //       style: TextStyle(fontSize: 18),
                  //     ),
                  //     Icon(Icons.arrow_forward)
                  //   ],
                  // ),
                  onPressed: logInUser,
                  child: _isLoading == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Log in',
                              style: TextStyle(fontSize: 18),
                            ),
                            Icon(Icons.arrow_forward)
                          ],
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      child: Text('Sign-up'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => SignupScreen())));
                      },
                    )
                  ],
                ),
                //signup
              ],
            ),
          ),
        ),
      )),
    );
  }
}
