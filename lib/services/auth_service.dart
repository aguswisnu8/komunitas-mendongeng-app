import 'dart:convert';

import 'package:kom_mendongeng/api_config.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = ApiConfig.getUrl();

  Future<UserModel> register({
    String? name,
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      // getCurrentUser(user.token.toString());
      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      // getCurrentUser(user.token.toString());
      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> getCurrentUser(String token) async {
    var url = '$baseUrl/user';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);
      return user;
    } else {
      throw Exception('Gagal Mendapatkan Data Current Logged User');
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
    var url = '$baseUrl/user';
    var headers = {
      // 'Content-Type': 'application/json',
      'Authorization': token.toString(),
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    if (filePath != null && filePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
          'profile_photo_path', filePath.toString()));
    }
    request.fields['name'] = name.toString();
    request.fields['email'] = email.toString();
    request.fields['alamat'] = alamat.toString();
    request.fields['medsos'] = medsos.toString();
    request.fields['deskripsi'] = deskripsi.toString();
    request.fields['exp'] = exp.toString();
    request.headers.addAll(headers);
    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    print(responseString);
    print("Servis Upadate Profile ${response.statusCode}");

    if (response.statusCode == 200) {
      // var data = jsonDecode(responseString['data']);
      print("Servis Upadate Berhasil");
      return true;
    } else {
      print("Servis Upadate Gagal");
      return false;
    }
  }

  Future<bool> logout(String token) async {
    var url = '$baseUrl/logout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);
    String message = jsonDecode(response.body)['meta']['message'];

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal LogOut');
      // return false;
    }
  }

  Future<bool> resetPassword(String password, String token) async {
    var url = '$baseUrl/reset';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);
    String message = jsonDecode(response.body)['meta']['message'];

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Reset Password');
      // return false;
    }
  }
}
