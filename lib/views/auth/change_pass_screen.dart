import 'package:bnchinamartt/core/utils/assets.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/data.dart';
import 'package:bnchinamartt/core/utils/validators.dart';
import 'package:bnchinamartt/core/widgets/custom_button.dart';
import 'package:bnchinamartt/core/widgets/custume_text_filed.dart';
import 'package:bnchinamartt/core/widgets/my_app_bard.dart';
import 'package:flutter/material.dart';

class ChangePassWordScreen extends StatefulWidget {
  const ChangePassWordScreen({super.key});

  @override
  State<ChangePassWordScreen> createState() => _ChangePassWordScreenState();
}

class _ChangePassWordScreenState extends State<ChangePassWordScreen> {
  final _formKey = GlobalKey<FormState>();

  String? newPass = '';

  void onSave(BuildContext context) {
    final isValidate = _formKey.currentState!.validate();
    if (!isValidate) {
      return;
    }
    _formKey.currentState!.save();

    if (isValidate) {
      for (var account in accounts) {
        if (account['username'] == currentUser["username"] &&
            account["email"] == currentUser["email"]) {
          account["password"] = newPass;
        }
      }
      addsnackbar(context, "Your password is updated");
    }
    Navigator.pop(context);
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
                  height: 40,
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
                CustomeTextFiled(
                  text: 'Current password',
                  icon: passwordIcon,
                  onValidate: (validate) {
                    if (validate == currentUser["password"]) {
                      return null;
                    }
                    return 'Your password is not correct';
                  },
                  onSaved: (newVlaue) {},
                  isObsecure: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomeTextFiled(
                  text: 'New password',
                  icon: passwordIcon,
                  onValidate: validatorPassword,
                  onSaved: (newVlaue) => newPass = newVlaue,
                  isObsecure: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  text: 'Update password',
                  onPressed: () {
                    onSave(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
