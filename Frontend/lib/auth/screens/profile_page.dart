import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/common/widgets/jeffe_button.dart';
import '../../constants.dart';
import '../controllers/user_profile_controller.dart';
import '../../common/widgets/custom_insertStars.dart';

// User? currentUser = _auth.currentUser;
String? phoneNumber;
String? name;
bool? isFemale;
int? rating;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Profile"),
              backgroundColor: loginTitleColor,
            ),
            body: Stack(children: [
              FutureBuilder<DocumentSnapshot>(
                  future: UserProfileController.getUserDataForCurrentUser(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      phoneNumber = data['phoneNumber'];
                      name = data['name'];
                      isFemale = data['isFemale'];
                      rating = data['rating'];
                      return Stack(children: [
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
                        ),
                        Column(children: [
                          const SizedBox(height: 50),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: loginTitleColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey,
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    )
                                  ]),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: const Icon(
                                Icons.person,
                                size: 75,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          //Name ---------------------------------------------------------------------------------------
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "$name",
                              style: const TextStyle(
                                  color: loginTitleColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(flex: 1),
                          // Number ---------------------------------------------------------------------------------------
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Number: $phoneNumber",
                              style: const TextStyle(
                                  color: loginTitleColor, fontSize: 15),
                            ),
                          ),
                          const Spacer(flex: 5),
                          //Rating ---------------------------------------------------------------------------------------
                          // Align(
                          //   alignment: Alignment.topCenter,
                          //   child: Text(
                          //     "Average Rating: $rating",
                          //     style: const TextStyle(
                          //         color: loginTitleColor, fontSize: 20),
                          //   ),
                          // ),
                          const Spacer(flex: 1),
                          Center(
                            child: InsertStars(numStars: rating!),
                          ),
                          const Spacer(flex: 1),

                          //Buttons ---------------------------------------------------------------------------------------
                          const Spacer(flex: 95),
                          JeffeButton(
                            text: "Link Spotify",
                            onTap: () => {},
                            buttoncolor: Colors.green,
                            textColor: Colors.black,
                            size: 270,
                          ),
                          const Spacer(flex: 3),
                          Row(
                            children: [
                              JeffeButton(
                                text: "Delete Account",
                                onTap: () => {},
                                buttoncolor: Colors.red,
                                textColor: Colors.white,
                                size: 200,
                              ),
                              const Spacer(flex: 5),
                              JeffeButton(
                                text: "Edit Account",
                                onTap: () => {},
                                buttoncolor: buttonColor,
                                textColor: Colors.white,
                                size: 200,
                              ),
                            ],
                          ),
                          const Spacer(flex: 25),
                        ]),
                      ]);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
            ])));
  }
}
