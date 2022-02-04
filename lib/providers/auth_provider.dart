import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;
  bool _logged = false;

  bool get logged => _logged;

  set logged(bool logged) {
    _logged = logged;
    notifyListeners();
  }

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String? name,
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        email: email,
        password: password,
      );

      _user = user;
      _logged = true;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;
      _logged = true;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logStatus(bool status) async {
    _logged = status;
    return true;
  }
}
