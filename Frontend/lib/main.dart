import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/activeCarpool/screens/active_carpool_page.dart';
import 'package:flutterapp/auth/screens/login_page.dart';
import 'package:flutterapp/home_Page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool inCarpool = prefs.getBool("inCarpool") ?? false;
    return GetMaterialApp(
        title: 'TripTogether',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((BuildContext context, snapshot) {
              if (FirebaseAuth.instance.currentUser == null) {
                return const LoginPage();
              } else if (inCarpool) {
                return const ActiveCarpoolPage();
              } else {
                return const HomePage();
              }
            })));
  }
}
