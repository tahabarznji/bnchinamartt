import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/data.dart';
import 'package:bnchinamartt/widgets/products/prouduct_card.dart';
import 'package:bnchinamartt/widgets/category/category_box.dart';
import 'package:bnchinamartt/core/widgets/my_app_bard.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.category});

  final String category;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Map<String, dynamic>> flitterdProduct = [];
  @override
  void initState() {
    flitterdProduct = products.where((product) {
      return product['category'] == widget.category;
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryBox(category: widget.category),
            flitterdProduct.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                      itemCount: flitterdProduct.length,
                      itemBuilder: (context, index) =>
                          ProductCard(listViewProduct: flitterdProduct[index]),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5),
                    ),
                  )
                : Center(
                    child: Text(
                      'The are not items for this cate gory',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
