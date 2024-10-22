import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/funtions.dart';
import 'package:bnchinamartt/models/product_data_model.dart';
import 'package:bnchinamartt/view_models/basket_product_provider.dart';
import 'package:bnchinamartt/widgets/category/category_box.dart';
import 'package:bnchinamartt/core/widgets/custom_button.dart';
import 'package:bnchinamartt/core/widgets/my_app_bard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductDataModel product;

  @override
  Widget build(BuildContext context) {
    BasketProductProvider basketProductProvider =
        Provider.of<BasketProductProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child:
                      Image.network(product.imgPath, height: 150, width: 150),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [CategoryBox(category: product.category)],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                product.name,
                style: TextStyle(
                    fontSize: 25,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                product.foodDetails,
                style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${product.price}',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' IQD',
                      style: TextStyle(
                          color: darkGreyColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(9),
        child: CustomButton(
          text: 'Add to basket',
          onPressed: () {
            basketProductProvider.addProduct(product);

            // addToBasked(context, product);
          },
        ),
      ),
    );
  }
}
