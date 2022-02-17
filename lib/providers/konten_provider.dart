import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/konten_model.dart';
import 'package:kom_mendongeng/services/konten_service.dart';

class KontenProvider with ChangeNotifier {
  List<KontenModel> _kontens = [];
  List<KontenModel> get kontens => _kontens;

  set kontens(List<KontenModel> kontens) {
    _kontens = kontens;
    notifyListeners();
  }

  List<KontenModel> _filterKontens = [];
  List<KontenModel> get filterKontens => _filterKontens;
  set filterKontens(List<KontenModel> kontens) {
    _filterKontens = kontens;
    notifyListeners();
  }

  Future<void> getKontens() async {
    try {
      List<KontenModel> kontens = await KontenService().getKontens();
      _kontens = kontens;
    } catch (e) {
      print(e);
    }
  }

  void getKontenByUserId(int? userid) {
    List<KontenModel> fkontens = [];
    for (var item in kontens) {
      // print('fkonten loop');
      // print('fkonten konten user id ${item.user?.id} - user ${userid}');
      if (item.user?.id == userid) {
        // print('fkonten masuk');
        fkontens.add(item);
      }
    }
    // print(fkontens.length);
    _filterKontens = fkontens;
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
    try {
      if (await KontenService().addKonten(
        judul: judul,
        filePath: filePath,
        link: link,
        deskripsi: deskripsi,
        jenis: jenis,
        status: status,
        token: token,
      )) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
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
    try {
      if (await KontenService().editKonten(
        id: id,
        judul: judul,
        filePath: filePath,
        link: link,
        deskripsi: deskripsi,
        jenis: jenis,
        status: status,
        token: token,
      )) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteKonten(
    int id,
    String token,
  ) async {
    try {
      if (await KontenService().deleteKonten(
        id,
        token,
      )) {
        return true;
      } else {
        return false;
      }
      // return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
