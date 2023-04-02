import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:get/get.dart';
import 'registrationpage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(color: Colors.white),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 4),
                  const Text(
                    "Login",
                    style: TextStyle(
                        color: registerTitleColor,
                        // fontWeight: FontWeight.bold,
                        fontSize: loginTitleFontSize),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please login into your account',
                    style: TextStyle(
                        color: kTextFieldLabelColor, fontSize: textTitles),
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
                  const SizedBox(height: 50),
                  InkWell(
                    // onTap: () => Get.to(RegistertionPage()),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(kDefaultPadding), // 15
                      decoration: const BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: buttonTextSize),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Flexible(
                        flex: 1,
                        child: Divider(
                          thickness: 1,
                          color: orLineColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          style: TextStyle(fontSize: 16, color: orLineColor),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Divider(
                          thickness: 1,
                          color: orLineColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        elevation: 4,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30),
                        child: CircleAvatar(
                          backgroundColor: facebookColor,
                          radius: 30,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesome.facebook,
                              color: Colors.white,
                              size: 32.0,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        elevation: 4,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30),
                        child: CircleAvatar(
                          backgroundColor: googleColor,
                          radius: 30,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesome.google,
                              color: Colors.white,
                              size: 32.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 34),
                  Center(
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Don't have an account?  ",
                            style: TextStyle(color: Colors.black)),
                        WidgetSpan(
                            child: GestureDetector(
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                color: registerTitleColor,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistertionPage()),
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
