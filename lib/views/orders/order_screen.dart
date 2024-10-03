import 'package:bnchinamartt/views/orders/orders_card.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/data.dart';
import 'package:bnchinamartt/core/widgets/my_app_bard.dart';
import 'package:bnchinamartt/core/widgets/order_banner.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: orders.isEmpty
              ? const Center(
                  child: Text('You dont have any orders'),
                )
              : Column(
                  children: [
                    const OrderBanner(),
                    const SizedBox(
                      height: 20,
                    ),
                    for (int i = 0; i < orders.length; i++)
                      OrdersCard(
                        order: orders[i],
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
