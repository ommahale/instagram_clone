import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    dynamic image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
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
                  height: 20,
                )
                //text area username
                ,
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: AssetImage('assets/avatar.jpg'),
                          ),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          icon: const Icon(Icons.add_a_photo),
                          onPressed: selectImage,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
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

                //button login
                //signup
                const SizedBox(
                  height: 20,
                ),
                //text area password
                CustomTextField(
                    iconData: Icons.person,
                    hintText: 'Enter your username',
                    isPass: false,
                    textEditingController: _usernameController,
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                //text area password
                CustomTextField(
                    iconData: Icons.info,
                    hintText: 'Enter your bio',
                    isPass: false,
                    textEditingController: _bioController,
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    AuthMethods().signupUser(
                        email: _emailController.text,
                        password: _passwordController.text,
                        username: _usernameController.text,
                        bio: _bioController.text,
                        profilePic: _image);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
