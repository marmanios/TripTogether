// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/common/widgets/custom_profilepage_button.dart';
import '../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
User? currentUser = _auth.currentUser;
String? phoneNumber;
String? name;
int? rating;

Future<DocumentSnapshot> getUserData() async {
  return await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.uid)
      .get();
}

class DisplayFarePage extends StatelessWidget {
  const DisplayFarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Arrived at Destination'),
          backgroundColor: loginTitleColor,
        ),
        body: Stack(
          children: [
            FutureBuilder<DocumentSnapshot>(
                future: getUserData(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    phoneNumber = data['phoneNumber'];
                    name = data['name'];
                    rating = data['rating'];
                    return Stack(
                      children: [
                        Container(
                            decoration:
                                const BoxDecoration(color: Colors.white)),
                        Column(
                          children: [
                            const SizedBox(height: 100),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Thank you for carpooling \n with us at TripTogether!',
                                style: TextStyle(
                                    color: loginTitleColor, fontSize: 34),
                              ),
                            ),
                            Spacer(flex: 5),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Fare: fareplaceholder',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                            Spacer(flex: 25),
                                ProfilePageButton(
                                  text: "Rate Passengers",
                                  onTap: () => {},
                                  size: 400,
                                  buttoncolor: loginTitleColor,
                                  textColor: Colors.white,
                                ),
                                Spacer(flex: 4),
                                ProfilePageButton(
                                  text: "Skip",
                                  onTap: () => {},
                                  size: 150,
                                  buttoncolor: loginTitleColor,
                                  textColor: Colors.white,
                                ),
                                Spacer(flex: 4),
                              ],
                            ),
                            Spacer(flex: 10),
                          ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                })
          ],
        ));
  }
}
