import 'package:flutter/material.dart';
import 'package:bnchinamartt/utils/assets.dart';
import 'package:bnchinamartt/utils/colors.dart';

class AuthBanner extends StatelessWidget {
  const AuthBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: whiteColor,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Image.asset(bnchinaMartLogo),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              avocado,
            ),
          ),
          Positioned(
            left: 30,
            bottom: 30,
            child: Image.asset(potato),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(lemon),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(blueberry),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(mango),
          ),
        ],
      ),
    );
  }
}
