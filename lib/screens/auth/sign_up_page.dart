import 'package:bnchinamartt/screens/auth/login_screen.dart';
import 'package:bnchinamartt/utils/data.dart';
import 'package:bnchinamartt/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:bnchinamartt/widgets/custome_banner.dart';
import 'package:bnchinamartt/widgets/custume_text_filed.dart';
import 'package:bnchinamartt/widgets/custom_button.dart';
import 'package:bnchinamartt/utils/colors.dart';
import 'package:bnchinamartt/utils/assets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? password;
  String? username;
  final _formKey = GlobalKey<FormState>();

  void register(BuildContext context) {
    final bool isValidate = _formKey.currentState!.validate();

    if (!isValidate) {
      return;
    }

    _formKey.currentState!.save();
    accounts.add({
      "username": username,
      "email": email,
      "password": password,
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
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
              'Create Free Acount',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: textColor),
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
                      text: 'username',
                      icon: usernameIcon,
                      onValidate: validatorUsername,
                      onSaved: (newVlaue) => password = newVlaue,
                    ),
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
                      text: 'Register',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('You Already have account?'),
                        TextButton(
                          onPressed: () {
                            register(context);
                          },
                          child: const Text('Login'),
                        )
                      ],
                    ),
                    const Text(
                      'Or',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
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
    ));
  }
}
