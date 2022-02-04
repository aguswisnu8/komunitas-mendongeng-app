import 'dart:convert';

import 'package:kom_mendongeng/api_config.dart';
import 'package:kom_mendongeng/models/anggota_model.dart';
import 'package:http/http.dart' as http;

class AnggotaService {
  String baseUrl = ApiConfig.getUrl();

  Future<List<AnggotaModel>> getAnggotas() async {
    var url = '$baseUrl/users';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];

      List<AnggotaModel> anggotas = [];
      for (var item in data) {
        anggotas.add(AnggotaModel.fromJson(item));
      }
      return anggotas;
    } else {
      throw Exception('Gagal Mendapatkan List Anggota');
    }
  }
}