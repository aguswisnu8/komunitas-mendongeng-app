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
}
