import 'package:bnchinamartt/screens/product/layout_screen.dart';
import 'package:bnchinamartt/screens/auth/sign_up_page.dart';
import 'package:bnchinamartt/utils/assets.dart';
import 'package:bnchinamartt/utils/colors.dart';
import 'package:bnchinamartt/utils/data.dart';
import 'package:bnchinamartt/utils/validators.dart';
import 'package:bnchinamartt/widgets/custom_button.dart';
import 'package:bnchinamartt/widgets/custome_banner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bnchinamartt/widgets/custume_text_filed.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  // dabe form state be nak form agadart ba
  final _formKey = GlobalKey<FormState>();
  void login(BuildContext context) {
    final bool isValidate = _formKey.currentState!.validate();

    if (!isValidate) {
      return;
    }
    _formKey.currentState!.save();

    try {
      final UserCredential = _firebase.signInWithEmailAndPassword(
          email: email!, password: password!);
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).clearSnackBars();
    }

    // bool isLogin = false;
    // for (var user in accounts) {
    //   if (user["email"] == email && user["password"] == password) {
    //     currentUser = user;
    //     isLogin = true;
    //     break;
    //   }
    // }

    // if (!isLogin) {
    //   errorsnackbar(context, "Invalid  Email or Password");
    //   return;
    // }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LayoutScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MarketBanner(),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Start Ordering!',
                style: TextStyle(color: textColor),
              ),
              Text(
                'Welcome Back',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomeTextFiled(
                        icon: emailIcon,
                        text: 'Email',
                        keybordtype: TextInputType.emailAddress,
                        onValidate: validatorEmail,
                        onSaved: (newVlaue) => email = newVlaue,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomeTextFiled(
                        text: 'Password',
                        icon: passwordIcon,
                        onValidate: validatorPassword,
                        onSaved: (newVlaue) => password = newVlaue,
                        isObsecure: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: 'Login',
                        onPressed: () {
                          login(context);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('You dont have account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text('Register'),
                          )
                        ],
                      ),
                      const Text(
                        'Or',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: lightBlueColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const ImageIcon(
                              AssetImage(googleLogo),
                            ),
                            Text(
                              'Login with Google',
                              style:
                                  TextStyle(color: darkBlueColor, fontSize: 20),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
