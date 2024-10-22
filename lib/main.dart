import 'package:bnchinamartt/view_models/basket_product_provider.dart';
import 'package:bnchinamartt/view_models/user_provider.dart';

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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(
          create: (context) => BasketProductProvider(),
        ),
      ],
      child: const BnchinaMartApp(),
    ),
  );
}

class BnchinaMartApp extends StatelessWidget {
  const BnchinaMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
