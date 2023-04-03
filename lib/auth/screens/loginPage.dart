import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:get/get.dart';
import '../../common/widgets/custom_textfield.dart';
import '../../common/widgets/custom_button.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../registrationpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() {}

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
              Container(
                padding: const EdgeInsets.all(8),
                child: Form(
                  //key: _signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        hideText: false,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        hideText: true,
                      ),
                      const SizedBox(height: 50),
                      CustomButton(
                        text: 'Sign In',
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
                      style: TextStyle(
                          fontSize: 16,
                          color: orLineColor,
                          fontWeight: FontWeight.bold),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesome.facebook,
                          color: facebookColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Material(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesome.google,
                          color: googleColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),
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
                              builder: (context) => RegistrationPage()),
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
