import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  String name;
  String email;
  bool isAdmin;
  String porfilePicture;
  String id;
  String governance;

  UserDataModel({
    required this.name,
    required this.email,
    required this.isAdmin,
    required this.porfilePicture,
    required this.id,
    required this.governance,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'isAdmin': isAdmin});
    result.addAll({'porfilePicture': porfilePicture});
    result.addAll({'id': id});
    result.addAll({'governance': governance});

    return result;
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      porfilePicture: map['porfilePicture'] ?? '',
      id: map['id'] ?? '',
      governance: map['governance'] ?? '',
    );
  }

  factory UserDataModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserDataModel.fromMap(data);
  }

  Map<String, dynamic> toFirestore() {
    return toMap();
  }

  // The copyWith method
  UserDataModel copyWith({
    String? name,
    String? email,
    bool? isAdmin,
    String? porfilePicture,
    String? id,
    String? governance,
  }) {
    return UserDataModel(
      name: name ?? this.name,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
      porfilePicture: porfilePicture ?? this.porfilePicture,
      id: id ?? this.id,
      governance: governance ?? this.governance,
    );
  }
}
