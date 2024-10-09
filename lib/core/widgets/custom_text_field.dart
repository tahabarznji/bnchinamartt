import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.iconPath,
    this.isPasswordField = false,
    this.isObsecure = false,
    this.keyboardType = TextInputType.text,
    this.errorMassage,
    this.onChanged,
  });
  final String hintText;
  final TextEditingController controller;
  final String? iconPath;
  final String? Function(String?)? validator;
  final bool isObsecure;
  final bool isPasswordField;
  final TextInputType keyboardType;
  final String? errorMassage;
  final Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;
  @override
  void initState() {
    obscureText = widget.isObsecure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: widget.errorMassage,
        errorMaxLines: 10,
        errorStyle: const TextStyle(
          fontSize: 12,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 12, color: darkGreyColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        filled: true,
        fillColor: greyColor,
        suffixIcon: widget.iconPath != null
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: ImageIcon(
                  AssetImage(widget.iconPath!),
                  color: darkGreyColor,
                  size: 24,
                ),
              )
            : null,
      ),
      validator: widget.validator,
      keyboardType: widget.keyboardType,
    );
  }
}
