import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/models/order_data_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat formater = DateFormat.yMd();

class OrdersCard extends StatelessWidget {
  const OrdersCard({super.key, required this.order});
  // final Map<String, dynamic> order;
  final OrderDataModel order;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lightGreyColor,
        ),
        height: 230,
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Order ID:',
                        style: TextStyle(
                            color: darkGreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      const WidgetSpan(
                          child: SizedBox(
                        width: 10,
                      )),
                      TextSpan(
                        text: order.orderId.toString(),
                        style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text(
                  formater.format(order.orderTime.toDate()).toString(),
                  style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: order.products.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: greyColor,
                    ),
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          order.products[index].imgPath,
                          fit: BoxFit.cover,
                          height: 75,
                        ),
                        Container(
                          height: 60,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            color: textColor,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          order.products[index].name.toString(),
                                      style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text: order.products[index].quantity
                                            .toString(),
                                        style: TextStyle(
                                            color: greyColor,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: ' psc',
                                        style: TextStyle(
                                            color: greyColor,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    order.products[index].totalPrice
                                        .ceil()
                                        .toString(),
                                    style: TextStyle(
                                        color: greyColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "IQD",
                                    style: TextStyle(
                                        color: greyColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'total:',
                      style: TextStyle(
                          color: darkGreyColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const WidgetSpan(
                        child: SizedBox(
                      width: 2,
                    )),
                    TextSpan(
                      text: order.totalAmount.ceil().toString(),
                      style: TextStyle(
                          color: textColor,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    const WidgetSpan(
                        child: SizedBox(
                      width: 2,
                    )),
                    TextSpan(
                      text: 'IQD',
                      style: TextStyle(
                          color: darkGreyColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
