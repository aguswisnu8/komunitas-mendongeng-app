import 'dart:convert';

import 'package:kom_mendongeng/api_config.dart';
import 'package:kom_mendongeng/models/partisipan_model.dart';
import 'package:http/http.dart' as http;

class PartisipanService {
  String baseUrl = ApiConfig.getUrl();

  Future<List<PartisipanModel>> getPartisipans() async {
    var url = '$baseUrl/partisipans';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];

      List<PartisipanModel> partisipans = [];
      for (var item in data) {
        partisipans.add(PartisipanModel.fromJson(item));
      }

      partisipans.sort((a, b) => b.mendongengId!.compareTo(a.mendongengId!));

      return partisipans;
    } else {
      throw Exception('Gagal Mendapatkan List Partisipan Kegiatan Mendongeng');
    }
  }

  Future<List> addPartisipan(
      int mendongengId, String peran, int stReq, String token) async {
    print('st : $stReq');
    var url = '$baseUrl/partisipans';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'mendongeng_id': mendongengId,
      'peran': peran,
      'st_req': stReq,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);
    String message = jsonDecode(response.body)['meta']['message'];
    List returnResponse = [message];
    if (response.statusCode == 200) {
      returnResponse.add(true);
      return returnResponse;
    } else {
      // throw Exception('Gagal Mendata Partisipan');
      returnResponse.add(false);
      return returnResponse;
    }
  }

  Future<bool> editPartisipan(int id, String peran, String token) async {
    var url = '$baseUrl/partisipans/$id';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'peran': peran,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    // bool test = true;

    // if (test) {
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Memperbaharui Peran');
    }
  }

  Future<bool> deletePartisipan(int id, String token) async {
    var url = '$baseUrl/partisipans/$id';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Menghapus Partisipan');
    }
  }
}
