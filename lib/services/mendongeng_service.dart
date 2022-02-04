import 'dart:convert';

import 'package:kom_mendongeng/api_config.dart';

import 'package:http/http.dart' as http;
import 'package:kom_mendongeng/models/mendongeng_model.dart';

class MendongengService {
  String baseUrl = ApiConfig.getUrl();

  Future<List<MendongengModel>> getMendongengs() async {
    var url = '$baseUrl/mendongengs';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];

      List<MendongengModel> mendongengs = [];
      for (var item in data) {
        mendongengs.add(MendongengModel.fromJson(item));
      }

      mendongengs.sort((a, b) => b.tgl.toString().compareTo(a.tgl.toString()));

      return mendongengs;
    } else {
      throw Exception('Gagal Mendapatkan List Kegiatan Mendongeng');
    }
  }
}
