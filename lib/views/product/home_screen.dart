import 'package:bnchinamartt/views/category/category_screen.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/widgets/products/horizantal_product_card.dart';
import 'package:bnchinamartt/widgets/category/category_list.dart';
import 'package:bnchinamartt/widgets/products/vertical_product_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/images/poster.png',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const CategoryList(),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(),
                      ));
                },
                child: const Text(
                  'See all Categories',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Text(
              'Trending Now',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 160,
              child: VerticalProductList(),
            ),
            Text(
              'All products',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const HorizantalProductList()
          ],
        ),
      ),
    );
  }
}
