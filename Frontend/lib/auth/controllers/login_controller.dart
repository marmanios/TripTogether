// ignore: file_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController {
  static final db = FirebaseFirestore.instance;

  static SnackBar generateSnackbar({required String text}) {
    return SnackBar(content: Text(text), backgroundColor: Colors.red);
  }

  static Future<void> signUpUser({
    required BuildContext context,
    required String name,
    required String password,
    required String email,
    required String phoneNumber,
    required String gender,
  }) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      UserCredential userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await db.collection('users').doc(userCredentials.user?.uid).set({
        "name": name,
        "phoneNumber": phoneNumber,
        "rating": 3,
        "isFemale": gender == "Female",
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            generateSnackbar(text: "Error: Password Provided Is Too Weak"));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(generateSnackbar(text: "Error: The Email Is In Use"));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
            generateSnackbar(text: "Error: Email Badly Formatted"));
      }
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pop();
  }

  // sign in user
  static Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context)
            .showSnackBar(generateSnackbar(text: "Error: Invalid Email"));
      } else if (e.code == 'user-disabled') {
        ScaffoldMessenger.of(context)
            .showSnackBar(generateSnackbar(text: "Error: Account Disabled"));
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(generateSnackbar(text: "Error: User Not Found"));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(generateSnackbar(text: "Error: Wrong Password"));
      }
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pop();
  }

  static Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleUser?.authentication;
    // ignore: unused_local_variable
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );
  }
}
