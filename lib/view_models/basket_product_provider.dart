import 'package:bnchinamartt/models/product_data_model.dart';
import 'package:flutter/material.dart';

class BasketProductProvider extends ChangeNotifier {
  final List<ProductDataModel> _basketProducts = [];

  List<ProductDataModel> get basektProducts => _basketProducts;
  void addProduct(ProductDataModel proudct) {
    int index =
        _basketProducts.indexWhere((element) => element.id == proudct.id);
    if (index == -1) {
      proudct.quantity = 1;
      proudct.totalPrice = proudct.price;
      _basketProducts.add(proudct);
    } else {
      _basketProducts[index].quantity += 1;
      _basketProducts[index].totalPrice += proudct.price;
    }
    notifyListeners();
  }

  void removeProduct(ProductDataModel product) {
    int index =
        _basketProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      if (_basketProducts[index].quantity > 1) {
        _basketProducts[index].quantity -= 1;
        _basketProducts[index].totalPrice -= product.price;
      } else {
        _basketProducts.removeAt(index);
      }
    }
    notifyListeners();
  }

  double totalPrice() {
    double total = 0;
    for (int i = 0; i < _basketProducts.length; i++) {
      total += _basketProducts[i].totalPrice;
    }
    return total;
  }

  void clear() {
    _basketProducts.clear();
    notifyListeners();
  }
}
