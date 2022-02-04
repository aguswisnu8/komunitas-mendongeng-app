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

  Future<void> getKontens() async {
    try {
      List<KontenModel> kontens = await KontenService().getKontens();
      _kontens = kontens;
    } catch (e) {
      print(e);
    }
  }
}
