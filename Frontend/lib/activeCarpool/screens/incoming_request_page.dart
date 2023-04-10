// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/common/widgets/custom_button.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/common/widgets/custom_button.dart';
import '../../constants.dart';

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

class IncomingRequestPage extends StatelessWidget {
  const IncomingRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Incoming Request'),
          backgroundColor: loginTitleColor,
          ),
        body: Stack(children: [
          FutureBuilder<DocumentSnapshot>(
            future: getUserData(),
            builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot){
                if (snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                  phoneNumber = data['phoneNumber'];
                  name = data['name'];
                  rating = data['rating'];
                  return Stack(children: [
                    Container(
                      decoration: const BoxDecoration(color: Colors.white)
                    ),
                    Column(children: [
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Passenger Name: $name',
                          style: TextStyle(color:loginTitleColor),
                        ),
                      ),
                      Spacer(flex: 1),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Passenger Phone Number: $phoneNumber',
                          style: TextStyle(color:loginTitleColor),
                        ),
                        ),
                      Spacer(flex: 1),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Passenger Rating: $rating Stars',
                          style: TextStyle(color:loginTitleColor),
                        ),
                        ),
                      Spacer(flex: 1),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'New Fare: placeholderfare',
                          style: TextStyle(color:loginTitleColor),
                        ),
                      ),
                      Spacer(flex: 1),
                      CustomButton(text: "Accept", onTap: ()=>{}),
                      Spacer(flex: 1),
                      CustomButton(text: "Reject", onTap: ()=>{}),
                    ],)
                  ],);
                }else{
                  return const CircularProgressIndicator();
              }
              }
                
        )],)
        
        
        
        // Column(
        //   children: [
        //   SizedBox(height: 10),
        //   Align(
        //     alignment: Alignment.topCenter,
        //     child: Text(
        //       'Passenger Name: placeholdername',
        //       style: TextStyle(color:loginTitleColor),
        //      ),
        //   ),
        //   // Spacer(flex: 1),
        //   Align(
        //     alignment: Alignment.topCenter,
        //     child: Text(
        //       'Passenger Rating: placeholderrating',
        //       style: TextStyle(color:loginTitleColor),
        //      ),
        //     ),
        //   // Spacer(flex: 1),
        //   Align(
        //     alignment: Alignment.topCenter,
        //     child: Text(
        //       'New Fare: placeholderfare',
        //       style: TextStyle(color:loginTitleColor),
        //     ),
        //   ),
        //   // Spacer(flex: 1),
        //   CustomButton(text: "Accept", onTap: ()=>{}),
        //   // Spacer(flex: 1),
        //   CustomButton(text: "Reject", onTap: ()=>{}),
        // ]
        

    )
    );
  }
}

// class MyWidget extends StatelessWidget {
//   final int numStars;

//   MyWidget({required this.numStars});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text('My Rating'),
//         Row(
//           children: buildStarIcons(numStars),
//         ),
//       ],
//     );
//   }
// }

// List<Widget> buildStarIcons(int numStars) {
//   List<Widget> stars = [];
//   for (int i = 0; i < numStars; i++) {
//     stars.add(Icon(Icons.star, color: Colors.yellow));
//   }
//   return stars;
// }
