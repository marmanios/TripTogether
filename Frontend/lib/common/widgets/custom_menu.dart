import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!_showMenu)
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.black,
            onPressed: () {
              setState(() {
                _showMenu = true;
              });
            },
          ),
        if (_showMenu)
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Button 1'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Button 2'),
              ),
            ],
          ),
      ],
    );
  }
}
