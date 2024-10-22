import 'package:bnchinamartt/core/services/auth_service.dart';
import 'package:bnchinamartt/core/utils/assets.dart';
import 'package:bnchinamartt/core/utils/colors.dart';

import 'package:bnchinamartt/core/utils/validators.dart';
import 'package:bnchinamartt/core/widgets/custom_button.dart';
import 'package:bnchinamartt/core/widgets/custom_text_field.dart';

import 'package:bnchinamartt/core/widgets/my_app_bard.dart';

import 'package:flutter/material.dart';

class ChangePassWordScreen extends StatefulWidget {
  const ChangePassWordScreen({super.key});

  @override
  State<ChangePassWordScreen> createState() => _ChangePassWordScreenState();
}

class _ChangePassWordScreenState extends State<ChangePassWordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  String? errorMassage;
  bool isLoading = false;

  Future<void> updatePassword() async {
    if (_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    errorMassage = await AuthService().changePasswordWithCurrentPassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text);
    if (errorMassage == null) {
      addsnackbar(context, 'The password is update scussfully');
    }
    setState(() {
      isLoading = false;
    });

    _currentPasswordController.clear();
    _newPasswordController.clear();
  }

  void onChanged(String value) {
    setState(() {
      if (errorMassage != null) {
        errorMassage = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(keyy),
                Text(
                  'Change Password',
                  style: TextStyle(
                      fontSize: 30,
                      color: textColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  isObsecure: true,
                  controller: _currentPasswordController,
                  hintText: 'Current password',
                  errorMassage: errorMassage,
                  iconPath: passwordIcon,
                  validator: validatorPassword,
                  onChanged: onChanged,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  controller: _newPasswordController,
                  hintText: 'New password',
                  errorMassage: errorMassage,
                  iconPath: passwordIcon,
                  isObsecure: true,
                  onChanged: onChanged,
                  validator: validatorPassword,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                if (isLoading) ...{
                  const CircularProgressIndicator(),
                } else ...{
                  CustomButton(
                    text: 'Update password',
                    onPressed: updatePassword,
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
