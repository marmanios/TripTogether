// This dart file was based off of
// https://github.com/RivaanRanawat/flutter-amazon-clone-tutorial/blob/master/lib/common/widgets/custom_textfield.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool hideText;
  final RegExp regex;
  final String labelText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.hideText,
    required this.labelText,
    required this.regex,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hideText,
      style: const TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
              color: kTextFieldLabelColor, fontSize: kTextFieldLabelSize),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kTextFieldLine),
          )),
      validator: (val) {
        if (val == null || val.isEmpty || !regex.hasMatch(val)) {
          return hintText;
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
