import 'package:bnchinamartt/utils/colors.dart';
import 'package:flutter/material.dart';

String? validatorEmail(email) {
  if (email == null || email.isEmpty) {
    return "Email is required";
  }

  if (!email.contains("@")) {
    return "Enter a valid email";
  }

  if (email.length < 5) {
    return "Please Enter at least 5 characters ";
  }

  return null;
}

String? validatorPassword(password) {
  if (password == null || password.isEmpty) {
    return "Password is required ";
  }
  if (password.length < 8) {
    return "Please Enter at least 8 characters";
  }
  return null;
}

String? validatorUsername(username) {
  if (username == null || username.isEmpty) {
    return "Username is required";
  }

  if (username.length < 5) {
    return "Please Enter at least 5 characters ";
  }

  return null;
}

void errorsnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: errorColor,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(),
      ),
    ),
  );
  return;
}

void addsnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: primaryColor,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
  return;
}
