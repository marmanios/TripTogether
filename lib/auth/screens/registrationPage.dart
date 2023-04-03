import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:get/get.dart';
import '../../common/widgets/custom_textfield.dart';
import '../../common/widgets/custom_button.dart';
import 'package:flutter_icons/flutter_icons.dart';
import './loginPage.dart';

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
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  void signUpUser() {}

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
              const Spacer(flex: 1),
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
              Container(
                padding: const EdgeInsets.all(8),
                child: Form(
                  //key: _signInFormKey,
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
                      CustomTextField(
                        controller: _phoneNumberController,
                        hintText: 'Phone Number',
                        hideText: false,
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
                      const SizedBox(height: 30),
                      CustomButton(
                        text: 'Register',
                        onTap: () {
                          // if (_signInFormKey.currentState!.validate()) {
                          //   signInUser();
                          // }
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
    ]));
  }
}
