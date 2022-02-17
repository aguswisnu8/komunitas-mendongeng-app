import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  // user return login response data
  late UserModel _user;
  UserModel get user => _user;
  // current user return data current login user
  late UserModel _currentUser;
  UserModel get currentUser => _currentUser;
  // login status
  bool _logged = false;
  bool get logged => _logged;

  set logged(bool logged) {
    _logged = logged;
    notifyListeners();
  }

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
      _currentUser = user;
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
      _currentUser = user;
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

  Future<bool> getCurrentUser(String token) async {
    try {
      UserModel user = await AuthService().getCurrentUser(token);
      _currentUser = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateUserProfile({
    String? filePath,
    String? name,
    String? email,
    String? alamat,
    String? medsos,
    String? deskripsi,
    int? exp,
    String? token,
  }) async {
    try {
      if (await AuthService().updateUserProfile(
        filePath: filePath,
        name: name,
        email: email,
        alamat: alamat,
        medsos: medsos,
        deskripsi: deskripsi,
        exp: exp,
        token: token,
      )) {
        getCurrentUser(token.toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout(String token) async {
    try {
      if (await AuthService().logout(token)) {
        logStatus(false);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword(String password, String token) async {
    try {
      if (await AuthService().resetPassword(password, token)) {
        logStatus(false);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
