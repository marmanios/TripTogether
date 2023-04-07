import 'package:flutter/material.dart';

import '../../constants.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);

  final String location;
  final void Function(String) press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          textColor: registerTitleColor,
          onTap: () => press(location),
          horizontalTitleGap: 0,
          leading: const Icon(Icons.location_city, color: buttonColor),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: kTextFieldLabelColor,
        ),
      ],
    );
  }
}
