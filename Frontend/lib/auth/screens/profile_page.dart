import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/common/widgets/custom_profilepage_button.dart';
import 'package:get/get.dart';
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
              backgroundColor: loginTitleColor,
              title: const Text("Profile"),
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
                          decoration: const BoxDecoration(
                              // image: DecorationImage(
                              //   image: AssetImage(
                              //       "assets/profilepagebackground.png"),
                              // ),
                              gradient: SweepGradient(colors: Colors.accents)),
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
                                  color: Colors.black,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    )
                                  ]),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  'assets/walterWhite.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          //Name ---------------------------------------------------------------------------------------
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "$name",
                              style: const TextStyle(
                                  color: Colors.black,
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
                                  color: Colors.black, fontSize: 15),
                            ),
                          ),
                          const Spacer(flex: 5),
                          //Rating ---------------------------------------------------------------------------------------
                          // Align(
                          //   alignment: Alignment.topCenter,
                          //   child: Text(
                          //     "Average Rating: $rating",
                          //     style: const TextStyle(
                          //         color: Colors.black, fontSize: 20),
                          //   ),
                          // ),
                          const Spacer(flex: 1),
                          Center(
                            child: InsertStars(numStars: rating!),
                          ),
                          const Spacer(flex: 1),

                          //Buttons ---------------------------------------------------------------------------------------
                          const Spacer(flex: 95),
                          ProfilePageButton(
                            text: "Link Spotify",
                            onTap: () => {UserProfileController.openSpotify()},
                            buttoncolor: Colors.green,
                            textColor: Colors.black,
                            size: 250,
                          ),
                          const Spacer(flex: 3),

                          ProfilePageButton(
                            text: "Delete Account",
                            onTap: () async {
                              bool confirmed = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Delete Account?"),
                                    content: const Text(
                                        "Are you sure you want to delete your account? This cannot be undone."),
                                    actions: [
                                      TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                      ),
                                      TextButton(
                                        child: const Text("Delete"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (confirmed == true) {
                                UserProfileController.deleteAccount(context);
                              }
                            },
                            buttoncolor: Colors.red,
                            textColor: Colors.black,
                            size: 250,
                          ),
                          const Spacer(flex: 5),

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
