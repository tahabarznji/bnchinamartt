import 'package:bnchinamartt/admin/admin_panel.dart';
import 'package:bnchinamartt/view_models/user_provider.dart';
import 'package:bnchinamartt/views/account/custome_tile.dart';
import 'package:bnchinamartt/auth/view/screens/change_pass_screen.dart';
import 'package:bnchinamartt/auth/view/screens/login_screen.dart';
import 'package:bnchinamartt/views/orders/order_screen.dart';
import 'package:bnchinamartt/core/services/auth_service.dart';
import 'package:bnchinamartt/core/utils/assets.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/data.dart';
import 'package:bnchinamartt/core/utils/validators.dart';
import 'package:bnchinamartt/core/widgets/custom_button.dart';
import 'package:bnchinamartt/core/widgets/custume_text_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcountScreen extends StatefulWidget {
  const AcountScreen({super.key});

  @override
  State<AcountScreen> createState() => _AcountScreenState();
}

class _AcountScreenState extends State<AcountScreen> {
  late UserProvider userProvider;
  // to get the user from the firestore
  final User? user = AuthService().currentUser;

  Future<void> signOut() async {
    await AuthService().signOut();
    userProvider.reset();
    debugPrint('SignOut seccssfully');
  }

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);

    super.initState();
  }

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
                Consumer<UserProvider>(
                  builder: (_, userProvider, child) {
                    return Text(
                      userProvider.getUserDataModel.name ?? 'null',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    );
                  },
                ),
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
              signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
          const Divider(
            height: 0,
          ),
          CoustomeTile(
            icon: signoutIcon,
            text: 'admin panel',
            onTap: () {
              signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPanel(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
// import 'package:bnchinamartt/auth/providers/user_provider.dart';
// // Corrected filename
// import 'package:bnchinamartt/auth/view/screens/change_pass_screen.dart';
// import 'package:bnchinamartt/auth/view/screens/login_screen.dart';
// import 'package:bnchinamartt/screens/account/custome_tile.dart';
// import 'package:bnchinamartt/screens/orders/order_screen.dart';
// import 'package:bnchinamartt/services/auth_service.dart';
// import 'package:bnchinamartt/utils/assets.dart';
// import 'package:bnchinamartt/utils/colors.dart';
// import 'package:bnchinamartt/utils/data.dart';
// import 'package:bnchinamartt/utils/validators.dart';
// import 'package:bnchinamartt/widgets/custom_button.dart';
// import 'package:bnchinamartt/widgets/custume_text_filed.dart';
// // Corrected filename
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AccountScreen extends StatefulWidget {
//   const AccountScreen({super.key});

//   @override
//   State<AccountScreen> createState() => _AccountScreenState();
// }

// class _AccountScreenState extends State<AccountScreen> {
//   late UserProvider userProvider;
//   bool _isProviderInitialized = false; // Flag to ensure single initialization

//   // To get the current user from Firebase Auth
//   final User? user = AuthService().currentUser;

//   // Form key for coupon validation
//   final _formKey = GlobalKey<FormState>();
//   String? couponCode;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_isProviderInitialized) {
//       // Initialize the UserProvider
//       userProvider = Provider.of<UserProvider>(context);
//       _isProviderInitialized = true;
//     }
//   }

//   /// Signs out the current user and resets the UserProvider
//   Future<void> signOut() async {
//     try {
//       await AuthService().signOut();
//       userProvider.reset();
//       debugPrint('Signed out successfully');
//       // Navigate to LoginScreen after sign out
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const LoginScreen(),
//         ),
//       );
//     } catch (e) {
//       debugPrint('Error signing out: $e');
//       // Optionally, show a snackbar or dialog with the error
//     }
//   }

//   /// Displays a modal bottom sheet for entering a coupon code
//   void showCouponBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // Ensures the sheet adjusts for the keyboard
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             top: 16,
//             left: 16,
//             right: 16,
//           ),
//           child: Container(
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Image.asset(coupon), // Ensure 'coupon' is a valid asset
//                     const SizedBox(height: 15),
//                     Text(
//                       'Enter Coupon Code',
//                       style: TextStyle(
//                         color: textColor,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     //  CustomeTextFiled(
//                     //     labelText: 'Coupon Code',
//                     //     icon: , // Example icon
//                     //     validator: (value) {
//                     //       if (value == null || value.trim().isEmpty) {
//                     //         return 'Please enter a coupon code';
//                     //       }
//                     //       if (value.trim().length < 4) {
//                     //         return 'The coupon code is too short';
//                     //       }
//                     //       return null;
//                     //     },
//                     //     onSaved: (newValue) => couponCode = newValue?.trim(),
//                     //   ),
//                     const SizedBox(height: 15),
//                     CustomButton(
//                       text: 'Check Coupon Code',
//                       onPressed: () {
//                         validateCoupon(context, () {
//                           Navigator.of(context).pop();
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 15),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// Validates the entered coupon code
//   void validateCoupon(BuildContext context, VoidCallback onPop) {
//     final bool isValid = _formKey.currentState?.validate() ?? false;

//     if (!isValid) {
//       return;
//     }

//     _formKey.currentState?.save();
//     bool isAvailableCoupon = false;

//     for (var coupon in coubons) {
//       // Ensure 'coupons' is defined in data.dart
//       if (coupon["code"].toString().toLowerCase() ==
//           couponCode?.toLowerCase()) {
//         currentUser["discount"] = coupon["discount"];

//         for (var user in accounts) {
//           // Ensure 'accounts' and 'currentUser' are defined
//           if (user['email'] == currentUser['email']) {
//             user["discount"] = coupon["discount"];
//             break;
//           }
//         }

//         isAvailableCoupon = true;
//         coubons.remove(coupon); // Removes the used coupon
//         break;
//       }
//     }

//     if (!isAvailableCoupon) {
//       showSnackbar(context, 'Invalid coupon code');
//     } else {
//       showSnackbar(context, 'You have successfully applied your discount');
//     }

//     onPop();
//   }

//   /// Displays a snackbar with the given message
//   void showSnackbar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               // User Profile Section
//               Container(
//                 alignment: Alignment.center,
//                 child: Column(
//                   children: [
//                     const CircleAvatar(
//                       backgroundImage:
//                           AssetImage(avatarBoy), // Ensure asset exists
//                       radius: 50,
//                     ),
//                     const SizedBox(height: 5),
//                     Consumer<UserProvider>(
//                       builder: (_, provider, __) {
//                         return Text(
//                           provider.getUserDataModel.name ?? 'User',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: textColor,
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 40),
//               // Account Options
//               CoustomeTile(
//                 icon: shoppingCart, // Use Flutter's built-in icons
//                 text: 'Orders',
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const OrderScreen(),
//                     ),
//                   );
//                 },
//               ),
//               const Divider(height: 0),
//               CoustomeTile(
//                 icon: lockIcon, // Use Flutter's built-in icons
//                 text: 'Change Password',
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const ChangePassWordScreen(),
//                     ),
//                   );
//                 },
//               ),
//               const Divider(height: 0),
//               CoustomeTile(
//                 icon: notificationIcon, // Use Flutter's built-in icons
//                 text: 'Notifications',
//                 onTap: () {
//                   // Implement notification settings navigation
//                 },
//               ),
//               const Divider(height: 0),
//               CoustomeTile(
//                 icon: starIcon, // Use Flutter's built-in icons
//                 text: 'Discount Offers',
//                 onTap: () {
//                   showCouponBottomSheet(context);
//                 },
//               ),
//               const Divider(height: 0),
//               CoustomeTile(
//                 icon: signoutIcon, // Use Flutter's built-in icons
//                 text: 'Sign Out',
//                 onTap: () {
//                   signOut();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
