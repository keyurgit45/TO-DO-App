import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_revision/consts/consts.dart';
import 'package:firebase_revision/services/firebase_auth_helper.dart';
import 'package:firebase_revision/utils/utils.dart';
import 'package:firebase_revision/views/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // void onpressed(context) {
  //   // ignore: avoid_print
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => const HomePage()));
  // }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isValid() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 2 - 130,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 2,
                  animatedTexts: [
                    TypewriterAnimatedText('Welcome Back',
                        speed: const Duration(milliseconds: 100), cursor: '.'),
                    // TypewriterAnimatedText(''),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, bottom: 30.0),
            child: Text(
              "Log in to your existing account.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0, bottom: 10, right: 22.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0, bottom: 40, right: 22.0),
            child: TextFormField(
              obscureText: true,
              controller: password,
              decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)))),
            ),
          ),
          Center(
            child: CupertinoButton(
              onPressed: () {
                if (isValid()) {
                  AuthHelper().logIn(email.text, password.text, context);
                } else {
                  Utils()
                      .snackBar(context, "Email and Password cannot be empty.");
                }
              },
              child: const Text("Log in"),
              color: AppColors().introPageColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: SignInButton(Buttons.Google, onPressed: () async {
            AuthHelper().signInWithGoogle(context);
          }))
        ],
      ),
    );
  }
}
