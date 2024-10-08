// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'product_data_model.dart'; // Ensure this imports your ProductDataModel

// class OrderDataModel {
//   final String orderId;
//   final Timestamp orderTime;
//   final double totalAmount;
//   final List<ProductDataModel> products;

//   OrderDataModel({
//     required this.orderId,
//     required this.orderTime,
//     required this.totalAmount,
//     required this.products,
//   });

//   // factory OrderDataModel.fromFirestore(DocumentSnapshot snapshot) {
//   //   Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
//   //   return OrderDataModel(
//   //     orderId: snapshot.id,
//   //     orderTime: map['orderTime'],
//   //     totalAmount: map['totalAmount'].toDouble(),
//   //     products: List<ProductDataModel>.from(
//   //       map['products']?.map((x) => ProductDataModel.fromFirestore(x)) ?? [],
//   //     ),
//   //   );
//   // }
//   factory OrderDataModel.fromFirestore(DocumentSnapshot snapshot) {
//     Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
//     return OrderDataModel(
//       orderId: snapshot.id,
//       orderTime: map['orderTime'],
//       totalAmount: map['totalAmount'].toDouble(),
//       products: List<ProductDataModel>.from(
//         (map['products'] as List).map((x) => ProductDataModel.fromFirestore(x)),
//       ),
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       'orderTime': orderTime,
//       'totalAmount': totalAmount,
//       'products': products.map((product) => product.toFirestore()).toList(),
//     };
//   }

//   OrderDataModel copyWith({
//     String? orderId,
//     Timestamp? orderTime,
//     double? totalAmount,
//     List<ProductDataModel>? products,
//   }) {
//     return OrderDataModel(
//       orderId: orderId ?? this.orderId,
//       orderTime: orderTime ?? this.orderTime,
//       totalAmount: totalAmount ?? this.totalAmount,
//       products: products ?? this.products,
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_data_model.dart';

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

  factory OrderDataModel.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    return OrderDataModel(
      orderId: snapshot.id,
      orderTime: map['orderTime'],
      totalAmount: map['totalAmount'].toDouble(),
      products: List<ProductDataModel>.from(
        (map['products'] as List).map(
          (productMap) => ProductDataModel.fromMap(productMap),
        ),
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'orderTime': orderTime,
      'totalAmount': totalAmount,
      'products': products.map((product) => product.toFirestore()).toList(),
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
