// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/common/widgets/custom_button.dart';
import 'package:flutterapp/common/widgets/m_button.dart';
import '../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
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
                    const SizedBox(height: 60),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Passenger Name: $name',
                        style: TextStyle(
                          color:loginTitleColor,
                          fontSize:24
                          ),
                      ),
                    ),
                    Spacer(flex: 2),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Passenger Phone Number: $phoneNumber',
                        style: TextStyle(
                          color:loginTitleColor,
                          fontSize:18
                          ),
                      ),
                      ),
                    Spacer(flex: 2),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Passenger Rating: $rating Stars',
                        style: TextStyle(
                          color:loginTitleColor,
                          fontSize:18
                          ),
                      ),
                      ),
                    Spacer(flex: 2),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'New Fare: placeholderfare',
                        style: TextStyle(
                          color:loginTitleColor,
                          fontSize:18
                          ),
                      ),
                    ),
                    Spacer(flex: 40),
                    Row(children: [
                      mButton(text: "Accept", onTap: ()=>{}, size: 200, buttoncolor: loginTitleColor, textColor: Colors.white,),
                      Spacer(flex: 4),
                      mButton(text: "Reject", onTap: ()=>{}, size: 200, buttoncolor: loginTitleColor, textColor: Colors.white,),
                    ],),
                    Spacer(flex:10),
                  ],)
                ],);
              }else{
                return const CircularProgressIndicator();
              }
            }
          )
        ],
      )
    );
  }
}
