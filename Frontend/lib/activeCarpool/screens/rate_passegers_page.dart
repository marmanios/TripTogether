// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterapp/common/widgets/custom_activepage_button.dart';
import 'package:flutterapp/common/widgets/custom_button.dart';
import 'package:flutterapp/common/widgets/custom_profilepage_button.dart';
import 'package:flutterapp/common/widgets/custom_textfield.dart';
import 'package:flutterapp/home_page.dart';
import 'package:get/get.dart';
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

class RatePassengersPage extends StatelessWidget {
  final List<Map<String, dynamic>> passengers;
  const RatePassengersPage({super.key, required this.passengers});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Rate Passengers Page'),
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
                      var _saveRating;
                      return Stack(
                        children: [
                          Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white)),
                          Column(
                            children: [
                              const SizedBox(height: 15),
                              // Align(
                              //   alignment: Alignment.topCenter,
                              //   child: Text(
                              //     'Rate Fellow Passengers',
                              //     style: TextStyle(
                              //         color: loginTitleColor, fontSize: 30),
                              //   ),
                              // ),
                              SizedBox(height: 10),
                              //Start

                              SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minWidth:
                                            MediaQuery.of(context).size.width),
                                    child: Container(
                                      height: 450,
                                      //color: Color.fromARGB(255, 255, 255, 255),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Passengers:",
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            //color: Color.fromARGB(
                                            //255, 255, 255, 255),
                                            child: Column(children: [
                                              Column(
                                                children: [
                                                  for (var passenger
                                                      in passengers)
                                                    // if (FirebaseAuth.instance.currentUser.)
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .account_circle_outlined,
                                                              color:
                                                                  Colors.black,
                                                              size: 30,
                                                            ),
                                                            Text(
                                                              passenger[
                                                                  "name"], //Placeholder name ---------------------------------------------------------------------------------------------------------------
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            RatingBar.builder(
                                                              initialRating: 3,
                                                              minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {
                                                                print(rating);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: 60,
                                                          color: Color.fromARGB(
                                                              255,
                                                              177,
                                                              177,
                                                              177),
                                                          alignment:
                                                              Alignment.center,
                                                          child: TextField(
                                                            decoration: InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                hintText:
                                                                    'Enter Comment'),
                                                          ),
                                                        ),
                                                        SizedBox(height: 20),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),

                              //end
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ActiveButton(
                                    text: "Submit Ratings",
                                    textSize: 15,
                                    newIcon: Icons.arrow_circle_right,
                                    buttoncolor: buttonColor,
                                    textColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 250,
                                    height: 60,
                                    image: 'assets/star.png',
                                    onTap: () => {Navigator.popUntil(context, (route) => route.isFirst)},
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ActiveButton(
                                    text: "Skip Ratings",
                                    textSize: 15,
                                    newIcon: Icons.arrow_circle_right,
                                    buttoncolor:
                                        Color.fromARGB(255, 125, 125, 125),
                                    textColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 250,
                                    height: 60,
                                    image: "assets/star.png",
                                    onTap: () => {Navigator.popUntil(context, (route) => route.isFirst)},
                                  ),
                                ],
                              )
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
