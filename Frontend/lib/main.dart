import 'package:flutter/material.dart';
import 'package:flutterapp/auth/screens/login_page.dart';
import 'package:flutterapp/homePage.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth/screens/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


// add library for getx

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'TripTogether',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((BuildContext context, snapshot) {
              if (FirebaseAuth.instance.currentUser == null) {
                return LoginPage();
              } else {
                //print(FirebaseAuth.instance.currentUser);
                return HomePage();
              }
            })));
  }
}
