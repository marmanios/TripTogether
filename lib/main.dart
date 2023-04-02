import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loginscreen.dart';
import 'registerscreen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

// add library for getx

void main() {
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
      home: RegisterScreen(),
    );
  }
}
