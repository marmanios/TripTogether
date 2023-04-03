// This dart file was based off of
// https://github.com/RivaanRanawat/flutter-amazon-clone-tutorial/blob/master/lib/common/widgets/custom_textfield.dart
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var maskFormatter = new MaskTextInputFormatter(
    mask: '(###) ###-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy); // or MaskAutoCompletionType.always

class CustomNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  CustomNumberField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
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
      inputFormatters: [maskFormatter],
      maxLines: maxLines,
    );
  }
}
