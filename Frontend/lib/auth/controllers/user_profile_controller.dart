import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/login_page.dart';
import '../screens/spotify.dart';

import 'package:get/get.dart';

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

  static void deleteAccount(BuildContext context) async {
    DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await userRef.delete();
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  static void openSpotify() {
    // ignore: prefer_const_constructors
    Get.to(Home());
  }
}
