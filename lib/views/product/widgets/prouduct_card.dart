import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/models/product_data_model.dart';
import 'package:bnchinamartt/view_models/basket_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productDataModel});
  // final Map<String, dynamic> listViewProduct;
  final ProductDataModel productDataModel;

  @override
  Widget build(BuildContext context) {
    BasketProductProvider basketProductProvider =
        Provider.of<BasketProductProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the container
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color with opacity
            spreadRadius: 1, // How far the shadow spreads
            blurRadius: 3, // Softening the edges of the shadow
            offset: const Offset(
                0, 3), // Horizontal and vertical offset of the shadow
          ),
        ],
        borderRadius:
            BorderRadius.circular(10), // Optional: rounding the corners
      ),
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
                    child: Image.network(
                      productDataModel.imgPath,
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
                        heroTag: '${productDataModel.imgPath} product',
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                        onPressed: () {
                          basketProductProvider.addProduct(productDataModel);
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
          ),
          Text(
            productDataModel.name,
            style: TextStyle(
                color: textColor, fontSize: 15, fontWeight: FontWeight.w900),
          ),
          Row(
            children: [
              Text(
                '${productDataModel.price}',
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
