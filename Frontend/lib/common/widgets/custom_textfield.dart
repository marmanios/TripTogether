// This dart file was based off of
// https://github.com/RivaanRanawat/flutter-amazon-clone-tutorial/blob/master/lib/common/widgets/custom_textfield.dart

import 'package:flutter/material.dart';
import '../../constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool hideText;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.hideText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hideText,
      style: const TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
          labelText: hintText,
          labelStyle: const TextStyle(
              color: kTextFieldLabelColor, fontSize: kTextFieldLabelSize),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kTextFieldLine),
          )),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
