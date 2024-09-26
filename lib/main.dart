import 'package:bnchinamartt/auth/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:bnchinamartt/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BnchinaMartApp());
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
      home: const Center(
        child: LoginScreen(),
      ),
    );
  }
}
