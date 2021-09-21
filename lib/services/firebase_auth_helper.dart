import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_revision/services/database_helper.dart';
import 'package:firebase_revision/utils/utils.dart';
import 'package:firebase_revision/views/pages/home_page.dart';
import 'package:firebase_revision/views/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  void signUp(String name, String email, String password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      DateTime date = DateTime.now();
      DataBaseHelper().addUser(name, email, date, context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("logged_in", "true");
      Utils().snackBar(context, "Dear " + name + ",you are signed up!");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils().snackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils().snackBar(context, 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void logIn(String email, String password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("logged_in", "true");
      Utils().snackBar(context, "Logged In successfully!");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils().snackBar(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Utils().snackBar(context, 'Wrong password provided for that user.');
      }
    }
  }

  void signInWithGoogle(context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        DataBaseHelper().addUser(userCredential.user!.displayName.toString(),
            userCredential.user!.email.toString(), DateTime.now(), context);
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("logged_in", "true");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      print(e);
    }
  }

  void logOut(context) async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('logged_in');
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => IntroPage()));
  }
}
