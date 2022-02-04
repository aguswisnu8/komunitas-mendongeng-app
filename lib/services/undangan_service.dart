import 'dart:convert';

import 'package:kom_mendongeng/api_config.dart';

import 'package:http/http.dart' as http;
import 'package:kom_mendongeng/models/undangan_model.dart';


class UndanganService {
  String baseUrl = ApiConfig.getUrl();

  Future<List<UndanganModel>> getUndangans() async {
    var url = '$baseUrl/undangans';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];

      List<UndanganModel> undangans = [];
      for (var item in data) {
        undangans.add(UndanganModel.fromJson(item));
      }

      return undangans;
    } else {
      throw Exception('Gagal Mendapatkan List Undangan');
    }
  }
}
