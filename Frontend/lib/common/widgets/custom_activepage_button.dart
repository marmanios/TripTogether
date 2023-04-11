// This dart file was based off of
// https://github.com/RivaanRanawat/flutter-amazon-clone-tutorial/blob/master/lib/common/widgets/custom_button.dart

import 'package:flutter/material.dart';
import '../../constants.dart';

class ActiveButton extends StatelessWidget {
  final String text;
  final double textSize;
  final VoidCallback onTap;
  final Color buttoncolor;
  final double height;
  final double width;
  final Color textColor;
  final String image;
  final IconData newIcon;
  const ActiveButton(
      {Key? key,
      required this.text,
      required this.textSize,
      required this.onTap,
      required this.buttoncolor,
      required this.height,
      required this.width,
      required this.textColor,
      required this.image,
      required this.newIcon})
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
            padding: const EdgeInsets.all(1),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  newIcon,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 25,
                ),
              ],
            )),
      ),
    );
  }
}
