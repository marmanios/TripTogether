import 'package:firebase_auth/firebase_auth.dart';

import '../../constants.dart';
import '../../common/widgets/custom_textfield.dart';
import '../../common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/offerCarpool/screens/qrCodeScannerPage.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:gradient_widgets/gradient_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Home Page'),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              label: const Text('Offer'),
              icon: const Icon(Icons.camera),
              onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRScannerPage()),
                    )
            ),
            ElevatedButton.icon(
              label: const Text('Offer'),
              icon: const Icon(Icons.camera),
              onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRScannerPage()),
                    )
            ),
          ],
        ),
      ),
    );
  }
}
