import 'package:bnchinamartt/models/product_data_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future<void> addProduct(ProductDataModel productDateModel) async {
  //   var refrence = _db.collection('products').doc();
  //   await refrence
  //       .set(productDateModel.copyWith(id: refrence.id).toFirestore());
  // }
  Future<void> addProduct(ProductDataModel productDateModel) async {
    var reference = _db.collection('products').doc(); // Generates a new ID
    await reference.set(productDateModel
        .copyWith(id: reference.id)
        .toFirestore()); // Updates the product model with the generated ID
  }

  Future<void> deleteProduct(String id) async {
    var refrence = _db.collection('products').doc(id);
    await refrence.delete();
  }

  Future<void> updateProduct(ProductDataModel productDateModel) async {
    var refrence = _db.collection('products').doc(productDateModel.id);
    await refrence.update(productDateModel.toFirestore());
  }

  Future<ProductDataModel?> getPruduct(String id) async {
    var refrence = _db.collection('products').doc(id);
    var doc = await refrence.get();
    if (doc.exists) {
      return ProductDataModel.fromFirestore(doc);
    } else {
      return null;
    }
  }
}
