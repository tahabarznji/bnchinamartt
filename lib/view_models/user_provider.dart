import 'package:bnchinamartt/models/user_data_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserDataModel _userDataModel = UserDataModel(
      email: '',
      governance: '',
      id: '',
      isAdmin: false,
      name: '',
      porfilePicture: '');

  UserDataModel get getUserDataModel => _userDataModel;

  UserDataModel setUserDataModel(UserDataModel udm) {
    _userDataModel = udm;
    notifyListeners();
    return _userDataModel;
  }

  void reset() {
    _userDataModel = UserDataModel(
      email: '',
      id: '',
      porfilePicture: '',
      name: '',
      governance: '',
      isAdmin: false,
    );
    notifyListeners();
  }
}
