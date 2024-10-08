import 'package:bnchinamartt/models/order_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addOrder(OrderDataModel order) async {}
}
