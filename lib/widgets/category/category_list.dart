import 'package:bnchinamartt/core/utils/data.dart';
import 'package:bnchinamartt/widgets/category/category_card.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Map<String, dynamic>> topCategory = [];
  @override
  void initState() {
    topCategory = categories.where((category) {
      return category["isTop"] == true;
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: topCategory.length,
      itemBuilder: (context, index) => CategoryCard(
        name: topCategory[index]["name"],
        imgPath: topCategory[index]["imgPath"],
        discount: topCategory[index]["discount"],
        isDiscount: topCategory[index]["discount"] == 0 ? false : true,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5),
    );
  }
}
