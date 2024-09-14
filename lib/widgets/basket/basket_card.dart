import 'package:bnchinamartt/utils/colors.dart';
import 'package:flutter/material.dart';

class BasketCard extends StatelessWidget {
  const BasketCard(
      {super.key,
      required this.baskedProduct,
      required this.onAdd,
      required this.onMinues});
  final Map<String, dynamic> baskedProduct;
  final VoidCallback onAdd;
  final VoidCallback onMinues;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 90,
              child: Center(
                child: Image.asset(
                  baskedProduct["imgPath"],
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    baskedProduct["name"],
                    style: TextStyle(
                        fontSize: 20,
                        color: textColor,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    baskedProduct["details"],
                    style: TextStyle(
                        fontSize: 15,
                        color: darkGreyColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        ' ${baskedProduct['totalPrice']} ',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'IQD',
                        style: TextStyle(color: darkGreyColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton.small(
                    heroTag: '${baskedProduct['imgPath']} Column',
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    onPressed: onMinues,
                    child: Icon(
                      Icons.remove,
                      color: whiteColor,
                    ),
                  ),
                  Text(
                    "${baskedProduct["quantity"]}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  FloatingActionButton.small(
                    heroTag: '${baskedProduct['imgPath']} Column',
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    onPressed: onAdd,
                    child: Icon(
                      Icons.add,
                      color: whiteColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
