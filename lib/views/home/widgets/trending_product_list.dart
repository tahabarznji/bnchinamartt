import 'package:bnchinamartt/models/product_data_model.dart';

import 'package:bnchinamartt/views/home/widgets/trending_product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrendingProductList extends StatefulWidget {
  const TrendingProductList({super.key});

  @override
  State<TrendingProductList> createState() => _TrendingProductListState();
}

class _TrendingProductListState extends State<TrendingProductList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return const Text('No products found');
        }

        final products = snapshot.data!.docs.where((element) {
          final product = ProductDataModel.fromFirestore(element);
          return product.isTrending;
        }).toList();
        return ListView.builder(
          itemCount: products.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final product = ProductDataModel.fromFirestore(products[index]);
            return TrendingProductCard(
              product: product,
            );
          },
        );
      },
    );
  }
}
