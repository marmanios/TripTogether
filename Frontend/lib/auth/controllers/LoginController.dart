import 'package:flutter/material.dart';

class LoginController {
  // sign up user
  static Future<void> signUpUser({
    required BuildContext context,
    required String name,
    required String password,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      print(name);
      print(password);
      print(email);
      print(phoneNumber);
    } catch (e) {}
  }

  // sign in user
  static Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      print(email);
      print(password);
    } catch (e) {}
  }

  // get user data
  static Future<void> getUserData(
    BuildContext context,
  ) async {
    try {} catch (e) {}
  }
}
