import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  final String? id;
  final String? name;
  final String? email;
  final bool? isAdmin;
  final String? porfilePicture;
  final String? governance;

  const UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
    required this.porfilePicture,
    required this.governance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
      'porfilePicture': porfilePicture,
      'governance': governance,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      isAdmin: map['isAdmin'] as bool,
      porfilePicture: map['porfilePicture'] as String,
      governance: map['governance'] as String,
    );
  }

  factory UserDataModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserDataModel.fromMap(data);
  }
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'porfilePicture': porfilePicture,
      'governance': governance,
      'isAdmin': isAdmin,
    };
  }

  // Map<String, dynamic> toFirestore() {
  //   return toMap();
  // }

  UserDataModel copyWith({
    String? name,
    String? email,
    bool? isAdmin,
    String? profilePicture,
    String? governance,
  }) {
    return UserDataModel(
      id: id, // Keeping the same ID; excluded from being modified
      name: name ?? this.name,
      porfilePicture: profilePicture ?? this.porfilePicture,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
      governance: governance ?? this.governance,
    );
  }
}
