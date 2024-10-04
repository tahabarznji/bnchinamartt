import 'package:bnchinamartt/models/user_data_model.dart';
import 'package:bnchinamartt/view_models/user_provider.dart';
import 'package:bnchinamartt/view_models/user_provider.dart';
import 'package:bnchinamartt/views/auth/login_screen.dart';
import 'package:bnchinamartt/views/product/layout_screen.dart';
import 'package:bnchinamartt/core/services/auth_service.dart';
import 'package:bnchinamartt/core/services/auth_firestore_service.dart';
import 'package:bnchinamartt/core/utils/data.dart';
import 'package:bnchinamartt/core/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bnchinamartt/widgets/auth_banner.dart';
import 'package:bnchinamartt/core/widgets/custume_text_filed.dart';
import 'package:bnchinamartt/core/widgets/custom_button.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/assets.dart';
import 'package:provider/provider.dart';

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
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      final UserCredential userCredential = await AuthService()
          .createUserWithEmailAndPassword(email: email!, password: password!);

      final String uId = userCredential.user!.uid;

      final newUserDataModel = UserDataModel(
        email: email!,
        name: username,
        id: uId,
        governance: '',
        isAdmin: false,
      );

      await AuthFirestoreService().addUser(newUserDataModel);
      userProvider.setUserDataModel(newUserDataModel);
      _formKey.currentState!.reset();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LayoutScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
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
                      onSaved: (newVlaue) => username = newVlaue,
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
                          createUserWithEmailAndPassword();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('You Already have account?'),
                        TextButton(
                          onPressed: () {
                            // register(context);
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
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
