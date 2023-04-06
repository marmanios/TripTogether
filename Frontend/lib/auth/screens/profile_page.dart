import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const double semicircle = 0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        backgroundColor: loginTitleColor,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          // Container(
          //   height: 175,
          //   decoration: const BoxDecoration(
          //     color: loginTitleColor,
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(semicircle),
          //       bottomRight: Radius.circular(semicircle),
          //     ),
          //   ),
          // ),
          Column(
            children: [
              SizedBox(height: 10),
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
                  margin: const EdgeInsets.only(
                      bottom: 10), // Adjust the margin to move the circle down
                  child: const Icon(
                    Icons.person,
                    size: 75,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "$name",
                  style: const TextStyle(color: loginTitleColor),
                ),
              ),
              Spacer(flex: 1),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Rating: $rating",
                  style: const TextStyle(color: loginTitleColor),
                ),
              ),
              Spacer(flex: 1),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Number: $phoneNumber",
                  style: const TextStyle(color: loginTitleColor),
                ),
              ),
              Spacer(flex: 50),
            ],
          ),
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
                return Container();
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
