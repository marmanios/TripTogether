import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common/widgets/custom_genderdropbox.dart';
import '../../constants.dart';
import '../../common/widgets/custom_textfield.dart';
import '../../common/widgets/custom_numberfield.dart';
import '../../common/widgets/custom_button.dart';
import 'login_page.dart';
import 'package:flutter/material.dart';
import '../controllers/LoginController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final TextEditingController _genderController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

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
                    color: registerTitleColor, fontSize: registerTitleFontSize),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        hintText:
                            'Name must only consist of roman alphabet letters and spaces',
                        hideText: false,
                        labelText: 'Full Name',
                        regex: RegExp(r'^[a-zA-Z ]+$'),
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email must follow format XXX@XXX.XX',
                        hideText: false,
                        labelText: 'Email',
                        regex: RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$'),
                      ),
                      CustomNumberField(
                        controller: _phoneNumberController,
                        hintText: 'Phone Number',
                      ),
                      GenderDropBox(onGenderChanged: (String? value) {
                        _genderController.text = value!;
                      }),
                      CustomTextField(
                        controller: _passwordController,
                        hintText:
                            'Needs 6+ characters, a capital letter & a symbol',
                        hideText: true,
                        labelText: 'Password',
                        regex: RegExp(r'^(?=.*?[A-Z])(?=.*?[!@#\$&*~]).{6,}$'),
                      ),
                      CustomButton(
                          text: 'Register',
                          onTap: () async => {
                                if (_signUpFormKey.currentState!.validate())
                                  {
                                    await LoginController.signUpUser(
                                            context: context,
                                            name: _nameController.text,
                                            email: _emailController.text,
                                            gender: _genderController.text,
                                            phoneNumber:
                                                _phoneNumberController.text,
                                            password: _passwordController.text)
                                        .then((value) => {
                                              if (FirebaseAuth
                                                      .instance.currentUser !=
                                                  null)
                                                {Navigator.pop(context)}
                                            })
                                  }
                              }),
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
