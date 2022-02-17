import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/anggota_model.dart';
import 'package:kom_mendongeng/services/anggota_service.dart';

class AnggotaProvider with ChangeNotifier {
  List<AnggotaModel> _anggotas = [];
  List<AnggotaModel> get anggotas => _anggotas;

  set anggotas(List<AnggotaModel> anggotas) {
    _anggotas = anggotas;
    notifyListeners();
  }

  Future<void> getanggotas() async {
    try {
      List<AnggotaModel> anggotas = await AnggotaService().getAnggotas();
      _anggotas = anggotas;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> editLevelAnggota(
    int id,
    String level,
    int active,
    String token,
  ) async {
    try {
      if (await AnggotaService().editLevelAnggota(id, level, active, token)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteAnggota(
    int id,
    String token,
  ) async {
    try {
      if (await AnggotaService().deleteAnggota(
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
