// This dart file was based off of
// https://github.com/RivaanRanawat/flutter-amazon-clone-tutorial/blob/master/lib/common/widgets/custom_button.dart

import 'package:flutter/material.dart';
import '../../constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(kDefaultPadding), // 15
        decoration: const BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: buttonTextColor,
              fontWeight: FontWeight.bold,
              fontSize: buttonTextSize),
        ),
      ),
    );
  }
}