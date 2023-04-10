import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/common/widgets/custom_button.dart';
import 'package:flutterapp/common/widgets/jeffe_button.dart';
import '../../constants.dart';

class InsertStars extends StatelessWidget {
  final int? numStars;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  InsertStars({this.numStars});

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
          padding: const EdgeInsets.all(8.0),
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
                style: const TextStyle(
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

List<Widget> buildStarIcons(int numStars) {
  List<Widget> stars = [];
  for (int i = 0; i < numStars; i++) {
    stars.add(const Icon(Icons.star, color: Colors.yellow, size: 30.0));
  }
  return stars;
}