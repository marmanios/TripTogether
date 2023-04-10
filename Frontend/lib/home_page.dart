import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/common/widgets/custom_home_button.dart';
import 'package:flutterapp/offerCarpool/screens/qr_code_scanner_page.dart';
import 'package:flutterapp/requestCarpool/screens/request_carpool_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';
import 'auth/screens/profile_page.dart';
import 'package:flutterapp/common/widgets/custom_profilepage_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

void _userLogout() {
  FirebaseAuth.instance.signOut();
}

void _viewProfile() {
  // ignore: prefer_const_constructors
  Get.to(ProfilePage());
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Geolocator.requestPermission();
  }

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
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisSize: MainAxisSize.min,
              //   children: const [
              //     SizedBox(height: 20),
              //     Text(
              //       "Welcome",
              //       style: TextStyle(color: registerTitleColor, fontSize: 40),
              //     ),
              //   ],
              // ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeButton(
                      text: "Offer Carpool",
                      //onTap: () => {},
                      buttoncolor: Color.fromARGB(90, 230, 230, 230),
                      textColor: Colors.black,
                      width: 180,
                      height: 200,
                      image: 'assets/car.png',
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QRCodeScannerPage()),
                        ),
                      },
                    ),
                    const SizedBox(width: 16.0),
                    HomeButton(
                      text: "Request Carpool",
                      //onTap: () => {},
                      buttoncolor: Color.fromARGB(90, 230, 230, 230),
                      textColor: Colors.black,
                      width: 180,
                      height: 200,
                      image: 'assets/vintageCar.png',
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RequestCarpoolPage()),
                        ),
                      },
                    ),
                  ],
                ),
              ),
            ])));
  }
}
