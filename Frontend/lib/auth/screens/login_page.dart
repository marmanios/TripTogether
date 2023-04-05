import 'registration_page.dart';
import '../../constants.dart';
import '../../common/widgets/custom_textfield.dart';
import '../../common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../controllers/LoginController.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:gradient_widgets/gradient_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
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
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        hideText: false,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        hideText: true,
                      ),
                      const SizedBox(height: 50),
                      CustomButton(
                        text: 'Sign In',
                        onTap: () async {
                          if (_signInFormKey.currentState!.validate()) {
                            await LoginController.signInUser(
                                context: context,
                                email: _emailController.text,
                                password: _passwordController.text);
                          }
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
                  const Spacer(flex: 5),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/google.png',
                        width: 50,
                        height: 50,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: Colors.white,
                          shadowColor: Colors.grey,
                          elevation: 5,
                          minimumSize: Size(70, 70),
                        ),
                        onPressed: () {
                          // Add your onPressed logic here
                        },
                        child: Image.asset(
                          'assets/google.png',
                          width: 45,
                          height: 45,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/facebook.png',
                        width: 50,
                        height: 50,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: facebookColor,
                          shadowColor: Colors.grey,
                          elevation: 5,
                          minimumSize: Size(70, 70),
                        ),
                        onPressed: () {
                          // Add your onPressed logic here
                        },
                        child: Image.asset(
                          'assets/facebook.png',
                          width: 45,
                          height: 45,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 5),
                ],
              ),
              const Spacer(flex: 2),
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
                                builder: (context) => const RegistrationPage()),
                          );
                        },
                      ),
                    ),
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
