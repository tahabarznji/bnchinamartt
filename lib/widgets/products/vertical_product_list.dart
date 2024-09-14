import 'package:bnchinamartt/utils/data.dart';
import 'package:bnchinamartt/widgets/products/vertical_product_card.dart';
import 'package:flutter/material.dart';

class VerticalProductList extends StatefulWidget {
  const VerticalProductList({super.key});

  @override
  State<VerticalProductList> createState() => _VerticalProductListState();
}

class _VerticalProductListState extends State<VerticalProductList> {
  List<Map<String, dynamic>> trendingProducts = [];
  @override
  void initState() {
    trendingProducts = products.where((product) {
      return product["isTrending"] == true;
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trendingProducts.length,
      itemBuilder: (context, index) {
        return VerticalProductCard(
          product: products[index],
        );
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
