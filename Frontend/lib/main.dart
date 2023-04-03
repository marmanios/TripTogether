import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/screens/registrationPage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// add library for getx

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TripTogether',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: RegistrationPage(),
    );
  }
}
