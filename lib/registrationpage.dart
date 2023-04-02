import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants.dart';
import 'loginpage.dart';

class RegistertionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 3),

                  const Text(
                    "Register",
                    style: TextStyle(
                        color: registerTitleColor,
                        // fontWeight: FontWeight.bold,
                        fontSize: registerTitleFontSize),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Please enter details to register',
                    style: TextStyle(
                        color: kTextFieldLabelColor, fontSize: textTitles),
                  ),

                  // Create a text field that is blank but has an underline
                  // and a hint text that says "Full Name"
                  const TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          color: kTextFieldLabelColor,
                          fontSize: kTextFieldLabelSize),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kTextFieldLine),
                      ),
                    ),
                  ),
                  const TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: kTextFieldLabelColor,
                          fontSize: kTextFieldLabelSize),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kTextFieldLine),
                      ),
                    ),
                  ),
                  const TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        labelStyle: TextStyle(
                            color: kTextFieldLabelColor,
                            fontSize: kTextFieldLabelSize),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kTextFieldLine))),
                  ),
                  const TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: kTextFieldLabelColor,
                          fontSize: kTextFieldLabelSize),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kTextFieldLine),
                      ),
                    ),
                  ),
                  const TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                          color: kTextFieldLabelColor,
                          fontSize: kTextFieldLabelSize),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kTextFieldLine),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  InkWell(
                    // onTap: () => Get.to(LoginPage()),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(kDefaultPadding),
                      decoration: const BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: buttonTextSize),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),

                  Center(
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: 'Already have an account?  ',
                            style: TextStyle(color: Colors.black)),
                        WidgetSpan(
                            child: GestureDetector(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: registerTitleColor,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                        ))
                      ]),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
