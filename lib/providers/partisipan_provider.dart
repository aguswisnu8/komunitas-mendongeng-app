import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/partisipan_model.dart';
import 'package:kom_mendongeng/services/partisipan_service.dart';

class PartisipanProvider with ChangeNotifier {
  List<PartisipanModel> _partisipans = [];
  List<PartisipanModel> get partisipans => _partisipans;

  set partisipans(List<PartisipanModel> partisipans) {
    _partisipans = partisipans;
    notifyListeners();
  }

  Future<void> getPartisipans() async {
    try {
      List<PartisipanModel> partisipans =
          await PartisipanService().getPartisipans();
      _partisipans = partisipans;
    } catch (e) {
      print(e);
    }
  }

  Future<List> addPartisipan(
    int mendongengId,
    String peran,
    String token,
  ) async {
    try {
      List response =
          await PartisipanService().addPartisipan(mendongengId, peran, token);
      return response;
    } catch (e) {
      print(e);
      return ['Pendataan Gagal', false];
    }
  }
}
