// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutterapp/common/widgets/custom_button.dart';
import '../../constants.dart';

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
        body: Column(
          children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Passenger Name: placeholdername',
              style: TextStyle(color:loginTitleColor),
             ),
          ),
          // Spacer(flex: 1),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Passenger Rating: placeholderrating',
              style: TextStyle(color:loginTitleColor),
             ),
            ),
          // Spacer(flex: 1),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'New Fare: placeholderfare',
              style: TextStyle(color:loginTitleColor),
            ),
          ),
          // Spacer(flex: 1),
          CustomButton(text: "Accept", onTap: ()=>{}),
          // Spacer(flex: 1),
          CustomButton(text: "Reject", onTap: ()=>{}),
        ]),
      ),
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
