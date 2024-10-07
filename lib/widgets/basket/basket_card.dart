import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/models/product_data_model.dart';
import 'package:bnchinamartt/view_models/basket_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasketCard extends StatefulWidget {
  const BasketCard({
    super.key,
    required this.productDataModel,
  });
  // final Map<String, dynamic> baskedProduct;
  // final Map<String, dynamic> baskedProduct;
  final ProductDataModel productDataModel;

  @override
  State<BasketCard> createState() => _BasketCardState();
}

class _BasketCardState extends State<BasketCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BasketProductProvider>(
        builder: (context, baseketProductProvider, _) {
      return Padding(
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
                  child: Image.network(
                    // baskedProduct["imgPath"],
                    widget.productDataModel.imgPath,
                    width: 70,
                    height: 70,
                    fit: BoxFit.contain,
                  ),
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
                      // baskedProduct["name"],
                      widget.productDataModel.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      widget.productDataModel.foodDetails,
                      style: TextStyle(
                          fontSize: 15,
                          color: darkGreyColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          ' ${widget.productDataModel.totalPrice} ',
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton.small(
                      heroTag: '${widget.productDataModel.imgPath} Column',
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                      onPressed: () {
                        baseketProductProvider
                            .removeProduct(widget.productDataModel);
                        // baskedProduct.removeProduct(widget.productDataModel);
                        // setState(() {});
                      },
                      child: Icon(
                        Icons.remove,
                        color: whiteColor,
                      ),
                    ),
                    Text(
                      "${widget.productDataModel.quantity}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    FloatingActionButton.small(
                      heroTag: '${widget.productDataModel.imgPath} Column',
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                      onPressed: () {
                        baseketProductProvider.addProduct(
                          widget.productDataModel,
                        );
                        // basketedProduct.addProduct(widget.productDataModel);
                        // baskedProduct.addProduct(widget.productDataModel);
                        // setState(() {});
                      },
                      child: Icon(
                        Icons.add,
                        color: whiteColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });

    // Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 5),
    //   child: Container(
    //     height: 100,
    //     decoration: BoxDecoration(
    //       color: lightGreyColor,
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //     padding: const EdgeInsets.all(4),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.end,
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         Container(
    //           padding: const EdgeInsets.all(5),
    //           decoration: BoxDecoration(
    //             color: whiteColor,
    //             borderRadius: BorderRadius.circular(8),
    //           ),
    //           height: 90,
    //           child: Center(
    //             child: Image.network(
    //               // baskedProduct["imgPath"],
    //               productDataModel.imgPath,
    //               width: 70,
    //               height: 70,
    //               fit: BoxFit.contain,
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           width: 20,
    //         ),
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 // baskedProduct["name"],
    //                 productDataModel.name,
    //                 style: TextStyle(
    //                     fontSize: 20,
    //                     color: textColor,
    //                     fontWeight: FontWeight.w900),
    //               ),
    //               Text(
    //                 productDataModel.foodDetails,
    //                 style: TextStyle(
    //                     fontSize: 15,
    //                     color: darkGreyColor,
    //                     fontWeight: FontWeight.bold),
    //               ),
    //               Row(
    //                 children: [
    //                   Text(
    //                     ' ${productDataModel.totalPrice} ',
    //                     style: TextStyle(
    //                         color: textColor,
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w900),
    //                   ),
    //                   const SizedBox(
    //                     width: 5,
    //                   ),
    //                   Text(
    //                     'IQD',
    //                     style: TextStyle(color: darkGreyColor),
    //                   ),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               FloatingActionButton.small(
    //                 heroTag: '${productDataModel.imgPath} Column',
    //                 backgroundColor: primaryColor,
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(19),
    //                 ),
    //                 onPressed: () {
    //                   baskedProduct.removeProduct(productDataModel);
    //                 },
    //                 child: Icon(
    //                   Icons.remove,
    //                   color: whiteColor,
    //                 ),
    //               ),
    //               Text(
    //                 "${productDataModel.quantity}",
    //                 style: const TextStyle(
    //                     fontSize: 20, fontWeight: FontWeight.bold),
    //               ),
    //               FloatingActionButton.small(
    //                 heroTag: '${productDataModel.imgPath} Column',
    //                 backgroundColor: primaryColor,
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(19),
    //                 ),
    //                 onPressed: () {
    //                   baskedProduct.addProduct(productDataModel);
    //                 },
    //                 child: Icon(
    //                   Icons.add,
    //                   color: whiteColor,
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
