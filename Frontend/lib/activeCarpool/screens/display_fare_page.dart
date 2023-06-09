// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/activeCarpool/screens/rate_passegers_page.dart';
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
  final List<Map<String, dynamic>> passengers;
  final double fare;
  const DisplayFarePage(
      {super.key, required this.passengers, required this.fare});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Fare Page'),
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
                              const SizedBox(height: 75),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'Desination \n Reached!',
                                  style: TextStyle(
                                      color: loginTitleColor, fontSize: 40),
                                ),
                              ),
                              SizedBox(height: 75),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'Fare Summary',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 25),
                              Container(
                                color: Colors.grey,
                                width: 300,
                                height: 150,
                                child: Center(
                                  child: Text(
                                    'Subtotal: \$${(fare).toStringAsFixed(2)} \n \n Tax: \$${(fare * .13).toStringAsFixed(2)} \n \n Total: \$${(fare * 1.13).toStringAsFixed(2)}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(height: 50),
                              ProfilePageButton(
                                text: "Rate Passengers",
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RatePassengersPage(
                                          passengers: passengers),
                                    ),
                                  )
                                },
                                size: 200,
                                buttoncolor: loginTitleColor,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                          // Spacer(flex: 10),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
            ],
          )),
    );
  }
}
