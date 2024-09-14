import 'package:bnchinamartt/screens/product_detail_screen.dart';
import 'package:bnchinamartt/utils/colors.dart';
import 'package:bnchinamartt/utils/funtions.dart';
import 'package:flutter/material.dart';

class VerticalProductCard extends StatelessWidget {
  VerticalProductCard({super.key, required this.product});

  Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        color: whiteColor,
        width: 100,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      product['imgPath'],
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: FloatingActionButton.small(
                        heroTag: ' FAB Vertical $product ',
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                        onPressed: () {
                          addToBasked(context, product);
                        },
                        child: Icon(
                          Icons.add,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              product['name'],
              style: TextStyle(
                  color: textColor, fontSize: 15, fontWeight: FontWeight.w900),
            ),
            Row(
              children: [
                Text(
                  '${product['price']}',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'IQD',
                  style: TextStyle(color: darkGreyColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
