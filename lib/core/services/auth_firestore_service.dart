import 'package:bnchinamartt/models/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(UserDataModel userDataModel) async {
    var refrence = _db.collection('users').doc(userDataModel.id);
    await refrence.set(userDataModel.toFirestore());
  }

  Future<void> deleteUser(String id) async {
    var refrence = _db.collection('users').doc(id);
    await refrence.delete();
  }

  Future<void> updateUser(UserDataModel userDataModel) async {
    var refrence = _db.collection('users').doc(userDataModel.id);
    await refrence.update(userDataModel.toFirestore());
  }

  Future<UserDataModel?> getUser(String id) async {
    var refrence = _db.collection('users').doc(id);
    var doc = await refrence.get();
    if (doc.exists) {
      return UserDataModel.fromFirestore(doc);
    } else {
      return null;
    }
  }
}
