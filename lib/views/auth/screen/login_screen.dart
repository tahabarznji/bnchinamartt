import 'package:bnchinamartt/core/widgets/custom_text_field.dart';
import 'package:bnchinamartt/view_models/user_provider.dart';
import 'package:bnchinamartt/views/home/screen/layout_screen.dart';
import 'package:bnchinamartt/views/auth/screen/sign_up_screen.dart';
import 'package:bnchinamartt/core/services/auth_service.dart';
import 'package:bnchinamartt/core/services/auth_firestore_service.dart';
import 'package:bnchinamartt/core/utils/assets.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/validators.dart';
import 'package:bnchinamartt/core/widgets/custom_button.dart';
import 'package:bnchinamartt/views/auth/widgets/auth_banner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserProvider userProvider;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwrodController = TextEditingController();
  @override
  void initState() {
    userProvider = Provider.of(context, listen: false);
    super.initState();
  }

  // dabe form state be nak form agadart ba
  final _formKey = GlobalKey<FormState>();

  Future<void> signInWithEmailAndPassword() async {
    final isValidate = _formKey.currentState!.validate();
    if (!isValidate) return;
    _formKey.currentState!.save();

    setState(() {
      isLoading = true;
    });
    try {
      final UserCredential userCredential = await AuthService()
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwrodController.text);
      if (userCredential == null) {
        debugPrint('User credintial is wrong');
        setState(() {
          isLoading = false;
        });
        return;
      }
      final userDataModel =
          await AuthFirestoreService().getUser(userCredential.user!.uid);
      if (userDataModel == null) {
        debugPrint('can not get user data model wrong');
        setState(() {
          isLoading = false;
        });
        return;
      }

      userProvider.setUserDataModel(userDataModel);

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LayoutScreen();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Failed with error code: ${e.code}');
      debugPrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AuthBanner(),
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
                      CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                          iconPath: emailIcon,
                          keyboardType: TextInputType.emailAddress,
                          validator: validatorEmail),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          controller: _passwrodController,
                          hintText: 'Password',
                          isObsecure: true,
                          iconPath: passwordIcon,
                          validator: validatorPassword),
                      const SizedBox(
                        height: 20,
                      ),
                      if (isLoading == true) ...{
                        const CircularProgressIndicator(),
                      } else
                        CustomButton(
                          text: 'Login',
                          onPressed: signInWithEmailAndPassword,
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
