import 'package:bnchinamartt/auth/view/screens/login_screen.dart';
import 'package:bnchinamartt/screens/product/layout_screen.dart';
import 'package:bnchinamartt/services/auth_service.dart';
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
