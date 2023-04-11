import 'package:flutter/material.dart';
import '../../constants.dart';

class mButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color buttoncolor;
  final double size;
  final Color textColor;
  const mButton(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.buttoncolor,
      required this.size,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(kDefaultPadding), // 15
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Text(
          text,
          style: TextStyle(
              // old one was buttonTextColor
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: buttonTextSize),
        ),
      ),
    );
  }
}