import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.listViewProduct});
  final Map<String, dynamic> listViewProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      color: whiteColor,
      width: 100,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      listViewProduct['imgPath'],
                      height: 90,
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
                        heroTag: '${listViewProduct['imgPath']} product',
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                        onPressed: () {},
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
          ),
          Text(
            listViewProduct['name'],
            style: TextStyle(
                color: textColor, fontSize: 15, fontWeight: FontWeight.w900),
          ),
          Row(
            children: [
              Text(
                '${listViewProduct['price']}',
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
    );
  }
}
