import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../common/widgets/custom_textfield.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
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
                              hintText: 'Email must follow format XXX@XXX.XX',
                              labelText: 'Email',
                              hideText: false,
                              regex: RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$'),
                            ),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Needs 6+ characters, a capital letter & a symbol',
                              hideText: true,
                              labelText: 'Password',
                              regex: RegExp(r'^(?=.*?[A-Z])(?=.*?[!@#\$&*~]).{6,}$'),
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
                      )
                    )
                  ]
                )
              )
            )
          );
        }}