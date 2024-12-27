
import 'package:bnchinamartt/core/services/auth_service.dart';
import 'package:bnchinamartt/views/auth/screen/login_screen.dart';
import 'package:bnchinamartt/views/home/screen/layout_screen.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const LayoutScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
