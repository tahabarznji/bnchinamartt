import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_data_model.dart'; // Ensure this imports your ProductDataModel

class OrderDataModel {
  final String orderId;
  final Timestamp orderTime;
  final double totalAmount;
  final List<ProductDataModel> products;

  OrderDataModel({
    required this.orderId,
    required this.orderTime,
    required this.totalAmount,
    required this.products,
  });

  factory OrderDataModel.fromMap(Map<String, dynamic> map, String documentId) {
    return OrderDataModel(
      orderId: documentId,
      orderTime: map['orderTime'],
      totalAmount: map['totalAmount'].toDouble(),
      products: List<ProductDataModel>.from(
        map['products']?.map((x) => ProductDataModel.fromMap(x)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'orderTime': orderTime,
      'totalAmount': totalAmount,
      'products': products.map((product) => product.toMap()).toList(),
    };
  }

  OrderDataModel copyWith({
    String? orderId,
    Timestamp? orderTime,
    double? totalAmount,
    List<ProductDataModel>? products,
  }) {
    return OrderDataModel(
      orderId: orderId ?? this.orderId,
      orderTime: orderTime ?? this.orderTime,
      totalAmount: totalAmount ?? this.totalAmount,
      products: products ?? this.products,
    );
  }
}
