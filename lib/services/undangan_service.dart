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

  Future<bool> addUndangan({
    String? nmKegiatan,
    String? pengirim,
    String? lokasi,
    String? tgl,
    String? deskripsi,
    String? jenis,
    String? penyelenggara,
    String? contact,
    String? status,
    String? token,
  }) async {
    var url = '$baseUrl/undangans';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token.toString(),
    };
    var body = jsonEncode({
      'pengirim': pengirim,
      'nm_kegiatan': nmKegiatan,
      'lokasi': lokasi,
      'tgl': tgl,
      'deskripsi': deskripsi,
      'jenis': jenis,
      'penyelenggara': penyelenggara,
      'contact': contact,
      'status': status,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Mendata Partisipan');
    }
  }

  Future<bool> editStatusUndangan(
    int id,
    String status,
    String token,
  ) async {
    var url = '$baseUrl/undangans/$id';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'status': status,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Memperbaharui Status Undangan');
    }
  }

  Future<bool> deleteUndangan(int id, String token) async {
    var url = '$baseUrl/undangans/$id';
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
      throw Exception('Gagal Menghapus Undangan');
    }
  }
}
