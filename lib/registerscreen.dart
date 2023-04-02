import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants.dart';
import 'loginscreen.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 1), //2/6
                  Center(
                    child: Text(
                      "𝙍𝙚𝙜𝙞𝙨𝙩𝙚𝙧",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 42),
                    ),
                  ),
                  Spacer(flex: 4),
                  Text(
                    "𝐅𝐮𝐥𝐥 𝐍𝐚𝐦𝐞",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: textTitles),
                  ),
                  TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kTextField,
                      hintText: 'Enter Your Full Name',
                      hintStyle: TextStyle(color: kHintStyle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: 39),

                  Text(
                    "𝐔𝐬𝐞𝐫𝐧𝐚𝐦𝐞",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: textTitles),
                  ),
                  TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kTextField,
                      hintText: 'Enter Your Username',
                      hintStyle: TextStyle(color: kHintStyle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "𝐏𝐚𝐬𝐬𝐰𝐬𝐨𝐫𝐝",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: textTitles),
                  ),
                  TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kTextField,
                      hintText: 'Enter Your Password',
                      hintStyle: TextStyle(color: kHintStyle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    obscureText: true,
                  ),
                  Spacer(
                    flex: 4,
                  ),

                  InkWell(
                    onTap: () => Get.to(LoginScreen()),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(kDefaultPadding), // 15
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "𝐂𝐨𝐧𝐭𝐢𝐧𝐮𝐞",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: buttonTextSize),
                      ),
                    ),
                  ),
                  Spacer(flex: 2), // it will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
