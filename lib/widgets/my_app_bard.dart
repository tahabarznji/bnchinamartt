import 'package:bnchinamartt/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar customAppBar() {
  return AppBar(
    // rangi appbar katek scroll dakai

    surfaceTintColor: Colors.transparent,

    backgroundColor: whiteColor,

    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Location',
          style: TextStyle(color: textColor, fontSize: 10),
        ),
        Row(
          children: [
            Text(
              'Ibrahim Pasha',
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.w900, fontSize: 16),
            ),
            const SizedBox(
              width: 5,
            ),
            const FaIcon(
              FontAwesomeIcons.angleDown,
              size: 15,
            )
          ],
        ),
      ],
    ),
  );
}
