import 'package:bnchinamartt/screens/account/custome_tile.dart';
import 'package:bnchinamartt/screens/auth/change_pass_screen.dart';
import 'package:bnchinamartt/screens/auth/login_screen.dart';
import 'package:bnchinamartt/screens/product/home_screen.dart';
import 'package:bnchinamartt/screens/orders/order_screen.dart';
import 'package:bnchinamartt/utils/assets.dart';
import 'package:bnchinamartt/utils/colors.dart';
import 'package:bnchinamartt/utils/data.dart';
import 'package:bnchinamartt/utils/validators.dart';
import 'package:bnchinamartt/widgets/custom_button.dart';
import 'package:bnchinamartt/widgets/custume_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AcountScreen extends ConsumerStatefulWidget {
  const AcountScreen({super.key});

  @override
  ConsumerState<AcountScreen> createState() => _AcountScreenState();
}

class _AcountScreenState extends ConsumerState<AcountScreen> {
  final _formKeyy = GlobalKey<FormState>();
  String? cobonCode;

  void showModeButtomSheet(BuildContext context, void Function() onPop) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKeyy,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(coupon),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Enter cupone code',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomeTextFiled(
                        text: 'Cupon code',
                        icon: null,
                        onValidate: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'The Cupon code is incorret';
                          }
                          return null;
                        },
                        onSaved: (newVlaue) => cobonCode = newVlaue,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        text: 'Check Cupon Code',
                        onPressed: () {
                          setState(() {
                            validateCobon(context, onPop);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void validateCobon(BuildContext context, void Function() onPop) {
    final bool isValidate = _formKeyy.currentState!.validate();

    if (!isValidate) {
      return;
    }

    _formKeyy.currentState!.save();
    bool isAvalibleCobon = false;

    for (var cubon in coubons) {
      if (cubon["code"] == cobonCode) {
        currentUser["discount"] == cubon["discount"];

        for (var user in accounts) {
          if (user['email'] == currentUser['email']) {
            user["discount"] = cubon["discount"];
          }
        }

        isAvalibleCobon = true;
        coubons.remove(cubon);

        break;
      }
    }

    if (!isAvalibleCobon) {
      addsnackbar(context, 'Invaild cobon code');
    } else {
      addsnackbar(context, 'You get your discount secufuly');
    }

    onPop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(avatarBoy),
                  radius: 50,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  currentUser['username'] ?? 'ME',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          CoustomeTile(
            icon: shoppingCart,
            text: 'Order',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OrderScreen(),
              ));
            },
          ),
          const Divider(
            height: 0,
          ),
          CoustomeTile(
            icon: lockIcon,
            text: 'Change Password',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePassWordScreen(),
                ),
              );
            },
          ),
          const Divider(
            height: 0,
          ),
          CoustomeTile(
            icon: notificationIcon,
            text: 'Notifications ',
            onTap: () {},
          ),
          const Divider(
            height: 0,
          ),
          CoustomeTile(
            icon: starIcon,
            text: 'Discount Offers',
            onTap: () {
              setState(() {
                showModeButtomSheet(context, () {
                  Navigator.of(context).pop();
                });
              });
            },
          ),
          const Divider(
            height: 0,
          ),
          CoustomeTile(
            icon: signoutIcon,
            text: 'Sign out',
            onTap: () {
              currentUser = {};
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
