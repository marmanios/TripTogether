import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserProfileController {
  static Future<DocumentSnapshot> getUserData(User? currentUser) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
  }

  static Future<DocumentSnapshot> getUserDataForCurrentUser() async {
    User? currentUser = _auth.currentUser;
    return await getUserData(currentUser);
  }
}
