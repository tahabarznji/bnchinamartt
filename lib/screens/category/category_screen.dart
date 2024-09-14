import 'package:bnchinamartt/utils/data.dart';
import 'package:bnchinamartt/widgets/category/category_card.dart';
import 'package:bnchinamartt/widgets/my_app_bard.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: GridView.builder(
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 16 / 9),
        itemBuilder: (context, index) {
          return CategoryCard(
            name: categories[index]["name"],
            imgPath: categories[index]["imgPath"],
            discount: categories[index]["discount"],
            isDiscount: categories[index]["discount"] == 0 ? false : true,
          );
        },
      ),
    );
  }
}
