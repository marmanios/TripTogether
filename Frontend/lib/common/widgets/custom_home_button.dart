// This dart file was based off of
// https://github.com/RivaanRanawat/flutter-amazon-clone-tutorial/blob/master/lib/common/widgets/custom_button.dart

import 'package:flutter/material.dart';
import '../../constants.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color buttoncolor;
  final double height;
  final double width;
  final Color textColor;
  final String image;
  const HomeButton(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.buttoncolor,
      required this.height,
      required this.width,
      required this.textColor,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(kDefaultPadding), // 15
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image),
                Text(text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                const Icon(
                  Icons.arrow_circle_right,
                  color: Colors.black,
                  size: 25,
                ),
              ],
            )),
      ),
    );
  }
}
