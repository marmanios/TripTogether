import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  @override
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
            icon: Icon(Icons.menu),
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
                child: Text('Button 1'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Button 2'),
              ),
            ],
          ),
      ],
    );
  }
}
