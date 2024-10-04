import 'package:flutter/material.dart';
import 'package:bnchinamartt/core/utils/colors.dart';

class NewTextfield extends StatelessWidget {
  NewTextfield(
      {super.key,
      required this.text,
      required this.icon,
      required this.onValidate,
      required this.onSaved,
      required this.controller,
      this.keybordtype = TextInputType.text,
      this.isObsecure = false});
  String text;
  String? icon;
  bool isObsecure;
  String? Function(String? value) onValidate;
  void Function(String? newVlaue) onSaved;
  final TextEditingController controller;
  TextInputType keybordtype;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObsecure,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(fontSize: 12, color: darkGreyColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        filled: true,
        fillColor: greyColor,
        suffixIcon: icon != null
            ? ImageIcon(
                AssetImage(icon!),
                color: darkGreyColor,
              )
            : null,
      ),
      validator: onValidate,
      onSaved: onSaved,
      keyboardType: keybordtype,
    );
  }
}
