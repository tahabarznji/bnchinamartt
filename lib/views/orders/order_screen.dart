import 'package:bnchinamartt/models/order_data_model.dart';
import 'package:bnchinamartt/views/orders/orders_card.dart';
import 'package:bnchinamartt/core/utils/colors.dart';

import 'package:bnchinamartt/core/widgets/my_app_bard.dart';
import 'package:bnchinamartt/core/widgets/order_banner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const OrderBanner(),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(auth.currentUser!.uid)
                    .collection('basket')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  final orders = snapshot.data!.docs.reversed.toList();
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = OrderDataModel.fromFirestore(orders[index]);
                      return OrdersCard(
                        order: order,
                        // order: orders[index],
                      );
                    },
                  );
                },
              )
              // for (int i = 0; i < orders.length; i++)
              //   OrdersCard(
              //     order: orders[i],
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
