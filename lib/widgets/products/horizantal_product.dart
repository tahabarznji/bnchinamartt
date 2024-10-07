import 'package:bnchinamartt/models/product_data_model.dart';
import 'package:bnchinamartt/view_models/basket_product_provider.dart';
import 'package:bnchinamartt/views/product_detail_screen.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/funtions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizantalProductCard extends StatelessWidget {
  const HorizantalProductCard({
    super.key,
    // required this.product,
    required this.productDataModel,
  });

  // final Map<String, dynamic> product;
  final ProductDataModel productDataModel;
  @override
  Widget build(BuildContext context) {
    BasketProductProvider basketProductProvider =
        Provider.of<BasketProductProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailScreen(product: productDataModel),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: lightGreyColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 90,
                child: Center(
                  // child: Image.asset(
                  //   // product["imgPath"],
                  //   productDataModel.imgPath,
                  //   width: 70,
                  //   height: 70,
                  //   fit: BoxFit.contain,
                  // ),
                  child: Image.network(productDataModel.imgPath,
                      width: 70, height: 70, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // product["name"],
                      productDataModel.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      // product["details"],
                      productDataModel.foodDetails ?? '',
                      style: TextStyle(
                          fontSize: 15,
                          color: darkGreyColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          productDataModel.price.toString(),
                          // ' ${product['price']} ',
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
              FloatingActionButton.small(
                heroTag: '${productDataModel.name} Column',
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                onPressed: () {
                  basketProductProvider.addProduct(productDataModel);
                  // addToBasked(context, product);
                },
                child: Icon(
                  Icons.add,
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
