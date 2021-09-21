import 'package:firebase_revision/consts/consts.dart';
import 'package:firebase_revision/views/pages/login_page.dart';
import 'package:firebase_revision/views/pages/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final List<Widget> pageviewchildren = [LoginPage(), SignUpPage()];

  var _selectedColor = 0;

  var pageviewcontroller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 20, bottom: 15),
          child: Row(
            children: [
              GestureDetector(
                child: Text(
                  "Log In",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: _selectedColor == 0
                          ? AppColors().introPageColor
                          : Colors.black),
                ),
                onTap: () {
                  pageviewcontroller.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);

                  setState(() {
                    _selectedColor = 0;
                  });
                },
              ),
              const SizedBox(
                width: 16,
              ),
              GestureDetector(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: _selectedColor == 1
                          ? AppColors().introPageColor
                          : Colors.black),
                ),
                onTap: () {
                  pageviewcontroller.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                  setState(() {
                    _selectedColor = 1;
                  });
                },
              )
            ],
          ),
        ),
        Expanded(
            child: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: pageviewchildren,
          controller: pageviewcontroller,
        ))
      ],
    ));
  }
}
