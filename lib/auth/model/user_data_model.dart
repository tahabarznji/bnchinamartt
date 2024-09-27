import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  String? id;
  String? name;
  String? email;
  bool? isAdmin;
  String? porfilePicture;

  String? governance;

  UserDataModel({
    this.name,
    this.email,
    this.isAdmin,
    this.porfilePicture,
    this.id,
    this.governance,
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
    String? profilePicture,
    String? governance,
  }) {
    return UserDataModel(
      id: this.id, // Keeping the same ID; excluded from being modified
      name: name ?? this.name,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,

      governance: governance ?? this.governance,
    );
  }
}
