import 'package:bnchinamartt/models/product_data_model.dart';
import 'package:bnchinamartt/models/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(ProductDataModel productDateModel) async {
    var refrence = _db.collection('products').doc(productDateModel.id);
    await refrence.set(productDateModel.toFirestore());
  }

  Future<void> deleteUser(String id) async {
    var refrence = _db.collection('products').doc(id);
    await refrence.delete();
  }

  Future<void> updateUser(ProductDataModel productDateModel) async {
    var refrence = _db.collection('products').doc(productDateModel.id);
    await refrence.update(productDateModel.toFirestore());
  }

  Future<ProductDataModel?> getUser(String id) async {
    var refrence = _db.collection('products').doc(id);
    var doc = await refrence.get();
    if (doc.exists) {
      return ProductDataModel.fromFirestore(doc);
    } else {
      return null;
    }
  }
}
