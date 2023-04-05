import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants.dart';
import '../../common/widgets/custom_textfield.dart';
import '../../common/widgets/custom_numberfield.dart';
import '../../common/widgets/custom_button.dart';
import 'login_page.dart';
import 'package:flutter/material.dart';
import '../controllers/LoginController.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  // void signUpUser() {
  //   final String name = _nameController.text;
  //   final String email = _emailController.text;
  //   final String password = _passwordController.text;

  //   // Save the registration data to a text file
  //   final String data = '$name, $email, $password\n';
  //   final File file = File('registration_data.txt');
  //   file.writeAsStringSync(data, mode: FileMode.append);

  //   // Show a dialog to confirm that the registration data was saved
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Registration complete'),
  //         content: const Text('Your registration data has been saved.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(color: Colors.white),
      ),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 6),
              const Text(
                "Register",
                style: TextStyle(
                    color: registerTitleColor,
                    // fontWeight: FontWeight.bold,
                    fontSize: registerTitleFontSize),
              ),
              const SizedBox(height: 4),
              const Text(
                'Please enter details to register',
                style: TextStyle(
                    color: kTextFieldLabelColor, fontSize: textTitles),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        hintText: 'Name',
                        hideText: false,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        hideText: false,
                      ),
                      CustomNumberField(
                        controller: _phoneNumberController,
                        hintText: 'Phone Number',
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        hideText: true,
                      ),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        hideText: true,
                      ),
                      //const Spacer(flex: 1),
                      CustomButton(
                        text: 'Register',
                        onTap: () async => {
                          if (_signUpFormKey.currentState!.validate()) {
                            await LoginController.signUpUser(
                                context: context,
                                name: _nameController.text,
                                email: _emailController.text,
                                phoneNumber: _phoneNumberController.text,
                                password: _passwordController.text).then((value) => {
                                  if(FirebaseAuth.instance.currentUser != null){
                                    Navigator.pop(context)
                                  }})
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Center(
                child: RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        text: "Already have an account?  ",
                        style: TextStyle(color: Colors.black)),
                    WidgetSpan(
                        child: GestureDetector(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: registerTitleColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ))
                  ]),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    ]));
  }
}
