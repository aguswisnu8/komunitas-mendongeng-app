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

  Future<bool> addKonten({
    String? judul,
    String? filePath,
    String? link,
    String? deskripsi,
    String? jenis,
    int? status,
    String? token,
  }) async {
    var url = '$baseUrl/kontens';
    var headers = {
      // 'Content-Type': 'application/json',
      'Authorization': token.toString(),
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('gambar', filePath.toString()));
    request.fields['judul'] = judul.toString();
    request.fields['link'] = link.toString();
    request.fields['deskripsi'] = deskripsi.toString();
    request.fields['jenis'] = jenis.toString();
    request.fields['status'] = status.toString();

    request.headers.addAll(headers);

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    print(responseString);
    print("Servis Upload Konten ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Servis Upload Berhasil");
      return true;
    } else {
      print("Servis Upload Gagal");
      return false;
    }
  }

  Future<bool> editKonten({
    int? id,
    String? judul,
    String? filePath,
    String? link,
    String? deskripsi,
    String? jenis,
    int? status,
    String? token,
  }) async {
    var url = '$baseUrl/kontens/$id';
    var headers = {
      // 'Content-Type': 'application/json',
      'Authorization': token.toString(),
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['judul'] = judul.toString();

    if (filePath != null && filePath.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('gambar', filePath.toString()));
    }
    request.fields['link'] = link.toString();

    request.fields['deskripsi'] = deskripsi.toString();

    request.fields['jenis'] = jenis.toString();

    request.fields['status'] = status.toString();

    request.headers.addAll(headers);

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    print(responseString);
    print("Servis Upload Konten ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Servis Upload Berhasil");
      return true;
    } else {
      print("Servis Upload Gagal");
      return false;
    }
  }

  Future<bool> deleteKonten(int id, String token) async {
    var url = '$baseUrl/kontens/$id';
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
      throw Exception('Gagal Menghapus Konten');
    }
  }
}
