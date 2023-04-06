import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/offerCarpool/screens/qrCodeScanner_page.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../common/widgets/custom_textfield.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_menu.dart';
import 'package:flutter/material.dart';
import 'auth/screens/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

void _userLogout() {
  FirebaseAuth.instance.signOut();
}

void _viewProfile() {
  Get.to(ProfilePage());
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // MaterialApp  with debugShowCheckedModeBanner
    // false and title.
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HomePage',
        // scaffold with appbar
        home: Scaffold(
            // appbar with title text
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                'TripTogether',
                style: TextStyle(color: registerTitleColor),
              ),
              // in action widget we have PopupMenuButton
              actions: [
                PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    // PopupMenuItem 1
                    PopupMenuItem(
                      value: 1,
                      // row with 2 children
                      child: Row(
                        children: const [
                          Icon(Icons.logout),
                          SizedBox(width: 10),
                          Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: const [
                          Icon(Icons.person),
                          SizedBox(width: 10),
                          Text(
                            "View Profile",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                  offset: const Offset(0, 55),
                  color: registerTitleColor,
                  elevation: 2,
                  // on selected we show the dialog box
                  onSelected: (value) {
                    if (value == 1) {
                      _userLogout();
                    } else if (value == 2) {
                      _viewProfile();
                    }
                  },
                ),
              ],
            ),
            body: Stack(children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
              ),
              const Spacer(flex: 1),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QRCodeScannerPage()),
                        );
                      },
                      child: const Text('Button 1'),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Button 2'),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1),
            ])));
  }
}
