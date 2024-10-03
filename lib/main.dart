import 'package:bnchinamartt/view_models/user_provider.dart';
import 'package:bnchinamartt/auth/view/screens/login_screen.dart';
import 'package:bnchinamartt/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const BnchinaMartApp(),
    ),
  );
}

class BnchinaMartApp extends StatelessWidget {
  const BnchinaMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bnchina Mart App',
      theme: ThemeData(
        //logcal font m dawati lera
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      // home: const Center(
      //   child: LoginScreen(),
      // ),
      home: const WidgetTree(),
    );
  }
}
