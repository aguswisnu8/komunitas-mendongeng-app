import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/mendongeng_model.dart';
import 'package:kom_mendongeng/services/mendongeng_service.dart';

class MendongengProvider with ChangeNotifier {
  List<MendongengModel> _mendongengs = [];
  List<MendongengModel> get mendongengs => _mendongengs;

  set mendongengs(List<MendongengModel> mendongengs) {
    _mendongengs = mendongengs;
    notifyListeners();
  }

  Future<void> getMendongengs() async {
    try {
      List<MendongengModel> mendongengs =
          await MendongengService().getMendongengs();
      _mendongengs = mendongengs;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> testImage(String filePath) async {
    try {
      if (await MendongengService().testImage(filePath)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
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
    int? udanganId,
    int? expReq,
    int? stReq,
    String? token,
  }) async {
    try {
      if (await MendongengService().addMendongeng(
        name: name,
        lokasi: lokasi,
        tgl: tgl,
        deskripsi: deskripsi,
        filePath: filePath,
        partner: partner,
        jenis: jenis,
        status: status,
        gmapLink: gmapLink,
        udanganId: udanganId,
        expReq: expReq,
        stReq: stReq,
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
}
