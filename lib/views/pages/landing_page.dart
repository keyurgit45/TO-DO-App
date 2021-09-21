import 'package:firebase_revision/views/pages/home_page.dart';
import 'package:firebase_revision/views/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("logged_in")) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => IntroPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: CircularProgressIndicator(
      color: Colors.lightBlue,
    )));
  }
}
