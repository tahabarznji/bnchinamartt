import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/data.dart';
import 'package:bnchinamartt/core/utils/validators.dart';
import 'package:bnchinamartt/widgets/basket/basket_card.dart';
import 'package:bnchinamartt/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:shortid/shortid.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  double totalPrice() {
    double total = 0;
    for (int i = 0; i < basketProducts.length; i++) {
      total += basketProducts[i]["totalPrice"];
    }

    if (currentUser["discount"] != 0) {
      total -= total * (currentUser["discount"] / 100);
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    if (basketProducts.isEmpty) {
      return Center(
        child: Text(
          "Your card is Empty !",
          style: TextStyle(
              fontSize: 20, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: basketProducts.length,
              itemBuilder: (context, index) => BasketCard(
                baskedProduct: basketProducts[index],
                onAdd: () {
                  setState(() {
                    basketProducts[index]["quantity"] =
                        basketProducts[index]["quantity"] + 1;
                    basketProducts[index]["totalPrice"] = basketProducts[index]
                            ["quantity"] *
                        basketProducts[index]["price"];
                  });
                },
                onMinues: () {
                  setState(() {
                    basketProducts[index]["quantity"] =
                        basketProducts[index]["quantity"] - 1;
                    basketProducts[index]["totalPrice"] = basketProducts[index]
                            ["quantity"] *
                        basketProducts[index]["price"];
                  });
                },
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
                  text: totalPrice().ceil().toString(),
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
            onPressed: () {
              setState(() {
                orders.add({
                  "orderID": shortid.generate(),
                  "totalPrice": totalPrice().ceil(),
                  "date": DateTime.now(),
                  "data": basketProducts,
                });
                basketProducts = [];
                currentUser["discount"] = 0;
                addsnackbar(context, 'Thanks for checkout');
              });
            },
          ),
        ],
      ),
    );
  }
}
