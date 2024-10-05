import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDataModel {
  final String id;
  final String name;
  final String imgPath;
  final String category;
  final double price;
  final String foodDetails;
  final bool isTrending;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.imgPath,
    required this.category,
    required this.price,
    required this.foodDetails,
    this.isTrending = false,
  });

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
      id: map['id'],
      name: map['name'],
      imgPath: map['imgPath'],
      category: map['category'],
      price: map['price'].toDouble(),
      foodDetails: map['foodDetails'],
      isTrending: map['isTrending'] ?? false,
    );
  }

  factory ProductDataModel.fromFirestore(DocumentSnapshot snapshot) {
    return ProductDataModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgPath': imgPath,
      'category': category,
      'price': price,
      'foodDetails': foodDetails,
      'isTrending': isTrending,
    };
  }

  Map<String, dynamic> toFirestore() {
    return toMap();
  }

  ProductDataModel copyWith({
    String? id,
    String? name,
    String? imgPath,
    String? category,
    double? price,
    String? foodDetails,
    bool? isTrending,
  }) {
    return ProductDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgPath: imgPath ?? this.imgPath,
      category: category ?? this.category,
      price: price ?? this.price,
      foodDetails: foodDetails ?? this.foodDetails,
      isTrending: isTrending ?? this.isTrending,
    );
  }
}
