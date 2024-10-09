import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoustomeTile extends StatelessWidget {
  const CoustomeTile(
      {super.key,
      required this.text,
      required this.icon,
      required this.onTap,
      this.widgetIcon});

  final String text;
  final String icon;
  final VoidCallback onTap;
  final Widget? widgetIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: widgetIcon ??
          SvgPicture.asset(
            icon,
            height: 26,
          ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
