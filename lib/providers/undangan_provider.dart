import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/undangan_model.dart';
import 'package:kom_mendongeng/services/undangan_service.dart';

class UndanganProvider with ChangeNotifier {
  List<UndanganModel> _undangans = [];
  List<UndanganModel> get undangans => _undangans;

  set undangans(List<UndanganModel> undangans) {
    _undangans = undangans;
    notifyListeners();
  }

  Future<void> getUndangans() async {
    try {
      List<UndanganModel> undangans = await UndanganService().getUndangans();
      _undangans = undangans;
    } catch (e) {
      print(e);
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
    try {
      if (await UndanganService().addUndangan(
        nmKegiatan: nmKegiatan,
        pengirim: pengirim,
        lokasi: lokasi,
        tgl: tgl,
        deskripsi: deskripsi,
        jenis: jenis,
        penyelenggara: penyelenggara,
        contact: contact,
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
}
