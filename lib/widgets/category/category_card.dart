import 'package:bnchinamartt/views/products.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard(
      {super.key,
      required this.name,
      required this.imgPath,
      this.discount = 30,
      this.isDiscount = false});
  String name;
  String imgPath;
  int discount;
  bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsScreen(category: name),
          ),
        );
      },
      child: Container(
        width: 180,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: lightGreyColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
                isDiscount
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: primaryColor),
                        child: Text(
                          '$discount% discount',
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
              ],
            ),
            Image.asset(
              imgPath,
              fit: BoxFit.cover,
              width: 75,
            )
          ],
        ),
      ),
    );
  }
}
