import 'package:bnchinamartt/views/account/account_screen.dart';
import 'package:bnchinamartt/views/basket/basket_screen.dart';
import 'package:bnchinamartt/views/product/home_screen.dart';
import 'package:bnchinamartt/core/utils/assets.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/widgets/my_app_bard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedScreen = 0;

  List<Widget> screen = [
    const HomeScreen(),
    const BasketScreen(),
    const AcountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar(),
      body: screen[selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedScreen,
        backgroundColor: lightGreyColor,
        selectedFontSize: 14,
        unselectedFontSize: 11,
        selectedIconTheme: IconThemeData(color: primaryColor),
        unselectedIconTheme: IconThemeData(color: darkGreyColor),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        onTap: (index) {
          setState(() {
            selectedScreen = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(homeIcon,
                  color: selectedScreen == 0 ? primaryColor : darkGreyColor),
              label: 'home'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(basketIcon,
                  color: selectedScreen == 1 ? primaryColor : darkGreyColor),
              label: 'shop'),
          const BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: AssetImage(avatarBoy),
                radius: 18,
              ),
              label: 'account'),
        ],
      ),
    );
  }
}
