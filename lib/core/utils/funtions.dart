import 'package:bnchinamartt/core/utils/data.dart';
import 'package:bnchinamartt/core/utils/validators.dart';
import 'package:flutter/material.dart';

void addToBasked(BuildContext context, listViewProduct) {
  bool isContain = false;

  for (int i = 0; i < basketProducts.length; i++) {
    if (basketProducts[i]["name"] == listViewProduct["name"]) {
      basketProducts[i]["quantity"] += 1;
      basketProducts[i]["totalPrice"] =
          basketProducts[i]["price"] * basketProducts[i]["quantity"];
      isContain = true;
      break;
    }
  }

  if (!isContain) {
    basketProducts.add({
      "name": listViewProduct["name"],
      "imgPath": listViewProduct["imgPath"],
      "details": listViewProduct["details"],
      "price": listViewProduct["price"],
      "category": listViewProduct["category"],
      "isTrending": listViewProduct["isTrending"],
      "quantity": 1,
      "totalPrice": listViewProduct["price"],
    });
  }

  addsnackbar(context, "The item has been added to your basket card");
}
