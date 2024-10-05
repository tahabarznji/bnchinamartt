import 'package:bnchinamartt/core/widgets/custom_text_field.dart';
import 'package:bnchinamartt/models/user_data_model.dart';
import 'package:bnchinamartt/view_models/user_provider.dart';
import 'package:bnchinamartt/view_models/user_provider.dart';
import 'package:bnchinamartt/views/auth/login_screen.dart';
import 'package:bnchinamartt/views/product/layout_screen.dart';
import 'package:bnchinamartt/core/services/auth_service.dart';
import 'package:bnchinamartt/core/services/auth_firestore_service.dart';

import 'package:bnchinamartt/core/utils/validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  Future<void> createUserWithEmailAndPassword() async {
    setState(() {
      isLoading = true;
    });

    try {
      final UserCredential userCredential = await AuthService()
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passController.text);

      // Ensure userCredential.user is not null
      if (userCredential.user == null) {
        throw Exception('User credential returned null user');
      }

      final String uId = userCredential.user!.uid;

      final UserDataModel newUserDataModel = UserDataModel(
        porfilePicture: '',
        email: _emailController.text,
        name: _nameController.text,
        id: uId,
        governance: '',
        isAdmin: false,
      );

      try {
        AuthFirestoreService().addUser(newUserDataModel);
        userProvider.setUserDataModel(newUserDataModel);
      } catch (e) {
        // Handle Firestore write errors
        debugPrint("Failed to add user data to Firestore: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add user to Firestore: $e')),
        );
        return; // Exit early if there's a Firestore error
      }

      // Reset the form only if it's not null
      _formKey.currentState?.reset();

      setState(() {
        isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LayoutScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint(e.message);
      // Optionally, show a snackbar or dialog with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Authentication Error')),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint(e.toString());
      // Optionally, show a snackbar or dialog with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add user: $e')),
      );
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
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'name',
                      iconPath: usernameIcon,
                      validator: validatorUsername,
                    ),
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
                        controller: _passController,
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
                        text: 'Register',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
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
