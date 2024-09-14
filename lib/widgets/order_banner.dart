import 'package:bnchinamartt/utils/assets.dart';
import 'package:bnchinamartt/utils/colors.dart';
import 'package:flutter/material.dart';

class OrderBanner extends StatelessWidget {
  const OrderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(receipt),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Past Orders',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: textColor),
            ),
          )
        ],
      ),
    );
  }
}
