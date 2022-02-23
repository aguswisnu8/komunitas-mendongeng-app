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

  Future<bool> testImage(String filePath) async {
    var url = '$baseUrl/test';
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': token,
    };
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..files.add(await http.MultipartFile.fromPath('gambar', filePath));
    var response = await request.send();
    print("Servis Upload ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Servis Upload Berhasil");
      return true;
    } else {
      print("Servis Upload Gagal");
      return false;
    }
  }

  Future<bool> addMendongeng({
    String? name,
    String? lokasi,
    String? tgl,
    String? deskripsi,
    String? filePath,
    String? partner,
    String? jenis,
    int? status,
    String? gmapLink,
    int? expReq,
    int? stReq,
    int? udanganId,
    String? token,
  }) async {
    var url = '$baseUrl/mendongengs';
    var headers = {
      // 'Content-Type': 'application/json',
      'Authorization': token.toString(),
    };
    var body = jsonEncode({
      'name': name,
      'lokasi': lokasi,
      'tgl': tgl,
      'deskripsi': deskripsi,
      'partner': partner,
      'jenis': jenis,
      'status': status,
      'gmap_link': gmapLink,
      'udangan_id': udanganId,
      'exp_req': expReq,
      'st_req': stReq,
    });
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('gambar', filePath.toString()));
    request.fields['name'] = name.toString();
    request.fields['lokasi'] = lokasi.toString();
    request.fields['tgl'] = tgl.toString();
    request.fields['deskripsi'] = deskripsi.toString();
    request.fields['partner'] = partner.toString();
    request.fields['jenis'] = jenis.toString();
    request.fields['status'] = status.toString();
    request.fields['gmap_link'] = gmapLink.toString();
    if (udanganId != null) {
      request.fields['udangan_id'] = udanganId.toString();
    }
    request.fields['exp_req'] = expReq.toString();
    request.fields['st_req'] = stReq.toString();
    request.headers.addAll(headers);

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    print(responseString);
    print("Servis Upload Mendongeng ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Servis Upload Berhasil");
      return true;
    } else {
      print("Servis Upload Gagal");
      return false;
    }
  }

  Future<bool> editMendongeng({
    int? id,
    String? name,
    String? lokasi,
    String? tgl,
    String? deskripsi,
    String? filePath,
    String? partner,
    String? jenis,
    int? status,
    String? gmapLink,
    int? expReq,
    int? stReq,
    String? token,
  }) async {
    var url = '$baseUrl/mendongengs/$id';
    var headers = {
      // 'Content-Type': 'application/json',
      'Authorization': token.toString(),
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    if (filePath != null && filePath.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('gambar', filePath.toString()));
    }
    request.fields['name'] = name.toString();
    request.fields['lokasi'] = lokasi.toString();
    request.fields['tgl'] = tgl.toString();
    request.fields['deskripsi'] = deskripsi.toString();
    request.fields['partner'] = partner.toString();
    request.fields['jenis'] = jenis.toString();
    request.fields['status'] = status.toString();
    request.fields['gmap_link'] = gmapLink.toString();
    request.fields['exp_req'] = expReq.toString();
    request.fields['st_req'] = stReq.toString();
    request.headers.addAll(headers);

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    print(responseString);
    print("Servis Upload Mendongeng ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Servis Upload Berhasil");
      return true;
    } else {
      print("Servis Upload Gagal");
      return false;
    }
  }

  Future<bool> deleteMendongeng(int id, String token) async {
    var url = '$baseUrl/mendongengs/$id';
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
      throw Exception('Gagal Menghapus Kegiatan');
    }
  }
}
