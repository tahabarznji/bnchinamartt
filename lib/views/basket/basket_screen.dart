import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/data.dart';
import 'package:bnchinamartt/core/utils/validators.dart';
import 'package:bnchinamartt/models/order_data_model.dart';
import 'package:bnchinamartt/view_models/basket_product_provider.dart';
import 'package:bnchinamartt/view_models/user_provider.dart';
import 'package:bnchinamartt/widgets/basket/basket_card.dart';
import 'package:bnchinamartt/core/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortid/shortid.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late UserProvider currentUser;
  @override
  void initState() {
    currentUser = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (basketProducts.isEmpty) {
    //   return Center(
    //     child: Text(
    //       "Your card is Empty !",
    //       style: TextStyle(
    //           fontSize: 20, color: primaryColor, fontWeight: FontWeight.bold),
    //     ),
    //   );
    // }
    return Consumer<BasketProductProvider>(
      builder: (context, basketProductProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: basketProductProvider.basektProducts.length,
                  itemBuilder: (context, index) => BasketCard(
                    productDataModel:
                        basketProductProvider.basektProducts[index],
                  ),
                ),
              ),
              const Divider(),
              const Text(
                'Total',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: basketProductProvider.totalPrice().toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: textColor),
                    ),
                    TextSpan(
                      text: ' IQD',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: darkGreyColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomButton(
                text: 'Check Out',
                onPressed: () async {
                  OrderDataModel order = OrderDataModel(
                    orderId: '',
                    orderTime: Timestamp.now(),
                    totalAmount: basketProductProvider.totalPrice(),
                    products: basketProductProvider.basektProducts,
                  );
                  final userId = FirebaseAuth.instance.currentUser!.uid;
                  var orderRef = FirebaseFirestore.instance
                      .collection('users')
                      .doc('$userId')
                      .collection('basket')
                      .doc();

                  order = order.copyWith(orderId: orderRef.id);

                  await orderRef.set(order.toMap());

                  basketProductProvider.clear();

                  addsnackbar(context, 'Thanks for checkout');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
