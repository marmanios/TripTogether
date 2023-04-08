import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/common/widgets/custom_button.dart';
import 'package:flutterapp/common/widgets/jeffe_button.dart';
import '../../constants.dart';
import '../../common/widgets/custom_semicircle.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
User? currentUser = _auth.currentUser;
String? phoneNumber;
String? name;
bool? isFemale;
int? rating;

Future<DocumentSnapshot> getUserData() async {
  return await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.uid)
      .get();
}

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
                  future: getUserData(),
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
                              "$name Smith",
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
                            child: insertStars(numStars: rating!),
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

//   @override
//   Widget build(BuildContext context) {
//     // ignore: avoid_unnecessary_containers
//     return Container(
//       child: Stack(
//         children: [
//         FutureBuilder<DocumentSnapshot>(
//           future: getUserData(),
//           builder:
//               (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               Map<String, dynamic> data =
//                   snapshot.data!.data() as Map<String, dynamic>;
//               phoneNumber = data['phoneNumber'];
//               name = data['name'];
//               isFemale = data['isFemale'];
//               rating = data['rating'];
//               return Scaffold(
//                 appBar: AppBar(
//                   centerTitle: true,
//                   title: const Text("Profile"),
//                   backgroundColor: loginTitleColor,
//                 ),
//                 body: Stack(
//                   children: [
//                     Container(
//                       decoration: const BoxDecoration(color: Colors.white),
//                     ),
//                     Column(
//                       children: [
//                         const SizedBox(height: 10),
//                         Align(
//                           alignment: Alignment.topCenter,
//                           child: Container(
//                             height: 100,
//                             width: 100,
//                             decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: loginTitleColor,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.blueGrey,
//                                     spreadRadius: 2,
//                                     blurRadius: 5,
//                                     offset: Offset(0, 3),
//                                   )
//                                 ]),
//                             margin: const EdgeInsets.only(
//                                 bottom:
//                                     10), // Adjust the margin to move the circle down
//                             child: const Icon(
//                               Icons.person,
//                               size: 75,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.topCenter,
//                           child: Text(
//                             "$name",
//                             style: const TextStyle(color: loginTitleColor),
//                           ),
//                         ),
//                         const Spacer(flex: 1),
//                         Align(
//                           alignment: Alignment.topCenter,
//                           child: Text(
//                             "Rating: $rating",
//                             style: const TextStyle(color: loginTitleColor),
//                           ),
//                         ),
//                         const Spacer(flex: 1),
//                         Align(
//                           alignment: Alignment.topCenter,
//                           child: Text(
//                             "Number: $phoneNumber",
//                             style: const TextStyle(color: loginTitleColor),
//                           ),
//                         ),
//                         const Spacer(flex: 50),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return const CircularProgressIndicator();
//             }
//           },
//         )
//       ]),
//     );
//   }
// }

// class insertStars extends StatelessWidget {
//   final int numStars;

//   insertStars({required this.numStars});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: buildStarIcons(numStars),
//     );
//   }
// }

// class insertStars extends StatelessWidget {
//   final int? numStars;

//   insertStars({this.numStars});

//   Widget build(BuildContext context) {
//     List<Widget> starIcons = [];
//     for (int i = 0; i < numStars!; i++) {
//       starIcons.add(Icon(Icons.star, color: Colors.yellow));
//     }

//     return Container(
//       padding: EdgeInsets.all(16.0), // Add some padding to the box
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey), // Add a border around the box
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: starIcons,
//       ),
//     );
//   }
// }

class insertStars extends StatelessWidget {
  final int? numStars;

  insertStars({this.numStars});

  Widget build(BuildContext context) {
    List<Widget> starIcons = [];
    for (int i = 0; i < numStars!; i++) {
      starIcons.add(Icon(Icons.star, color: Colors.yellow));
    }

    return SizedBox(
      width: 200.0, // Set a fixed width for the box
      height: 70.0, // Set a fixed height for the box
      child: Center(
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: loginTitleColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: starIcons,
              ),
              SizedBox(height: 8.0),
              Text(
                "Average Rating: $numStars stars",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class insertStars extends StatelessWidget {
//   final int? numStars;

//   insertStars({this.numStars});

//   Widget build(BuildContext context) {
//     List<Widget> starIcons = [];
//     for (int i = 0; i < numStars!; i++) {
//       starIcons.add(Icon(Icons.star, color: Colors.yellow));
//     }

//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: starIcons,
//           ),
//           SizedBox(
//               height: 8.0), // Add some space between the stars and the text
//           Text(
//             "Average Rating: $numStars stars", // Display the number of stars as text
//             style: TextStyle(color: loginTitleColor, fontSize: 18.0),
//           ),
//         ],
//       ),
//     );
//   }
// }

List<Widget> buildStarIcons(int numStars) {
  List<Widget> stars = [];
  for (int i = 0; i < numStars; i++) {
    stars.add(Icon(Icons.star, color: Colors.yellow, size: 30.0));
  }
  return stars;
}
