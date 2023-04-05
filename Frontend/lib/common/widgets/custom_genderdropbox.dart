import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';

const List<String> list = <String>['Gender', 'Male', 'Female', 'Other'];
typedef GenderCallback = void Function(String? value);

class GenderDropBox extends StatefulWidget {
  final GenderCallback onGenderChanged;

  const GenderDropBox({
    super.key,
    required this.onGenderChanged,
  });

  @override
  // ignore: no_logic_in_create_state
  State<GenderDropBox> createState() => _GenderDropxBoxSate();
}

class _GenderDropxBoxSate extends State<GenderDropBox> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(
            color: kTextFieldLabelColor, fontSize: kTextFieldLabelSize),
        underline: Container(
          height: 1,
          color: kTextFieldLabelColor,
        ),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
          widget.onGenderChanged(value);
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
