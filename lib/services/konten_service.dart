import 'dart:convert';

import 'package:kom_mendongeng/api_config.dart';

import 'package:http/http.dart' as http;
import 'package:kom_mendongeng/models/konten_model.dart';

class KontenService {
  String baseUrl = ApiConfig.getUrl();

  Future<List<KontenModel>> getKontens() async {
    var url = '$baseUrl/kontens';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];

      List<KontenModel> kontens = [];
      for (var item in data) {
        // list.insert(0, "A"); adding first [0]
        kontens.insert(0, KontenModel.fromJson(item));
        // kontens.add(KontenModel.fromJson(item));

      }
      return kontens;
    } else {
      throw Exception('Gagal Mendapatkan List Konten');
    }
  }
}
