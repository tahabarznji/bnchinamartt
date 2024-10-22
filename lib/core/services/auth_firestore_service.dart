// class AuthFirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   Future<void> addUser(UserDataModel userDataModel) async {
//     var refrence = _db.collection('users').doc(userDataModel.id);
//     await refrence.set(userDataModel.toFirestore());
//   }

//   Future<void> deleteUser(String id) async {
//     var refrence = _db.collection('users').doc(id);
//     await refrence.delete();
//   }

//   Future<void> updateUser(UserDataModel userDataModel) async {
//     var refrence = _db.collection('users').doc(userDataModel.id);
//     await refrence.update(userDataModel.toFirestore());
//   }

//   Future<UserDataModel?> getUser(String id) async {
//     var refrence = _db.collection('users').doc(id);
//     var doc = await refrence.get();
//     if (doc.exists) {
//       return UserDataModel.fromFirestore(doc);
//     } else {
//       return null;
//     }
//   }
// }

import 'package:bnchinamartt/models/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(UserDataModel userDataModel) async {
    try {
      var reference = _db.collection('users').doc(userDataModel.id);
      await reference.set(userDataModel.toFirestore());
    } catch (e) {
      throw Exception("Failed to add user to Firestore: $e");
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      var reference = _db.collection('users').doc(id);
      await reference.delete();
    } catch (e) {
      throw Exception("Failed to delete user");
    }
  }

  Future<void> updateUser(UserDataModel userDataModel) async {
    try {
      var reference = _db.collection('users').doc(userDataModel.id);
      await reference.update(userDataModel.toFirestore());
    } catch (e) {
      throw Exception("Failed to update user");
    }
  }

  // Future<UserDataModel?> getUser(String id) async {
  //   try {
  //     var reference = _db.collection('users').doc(id);
  //     var doc = await reference.get();
  //     if (doc.exists) {
  //       print("User fetched successfully.");
  //       return UserDataModel.fromFirestore(doc);
  //     } else {
  //       print("User not found.");
  //       return null;
  //     }
  //   } catch (e) {
  //     print("Failed to fetch user: $e");
  //     throw Exception("Failed to fetch user");
  //   }
  // }
  Future<UserDataModel?> getUser(String id) async {
    try {
      var reference = _db.collection('users').doc(id);
      var doc = await reference.get();
      if (doc.exists) {
        // Print the raw data
        return UserDataModel.fromFirestore(doc);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Failed to fetch user");
    }
  }
}
