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
    int id,
    String peran,
    int stReq,
    String token,
  ) async {
    try {
      List response =
          await PartisipanService().addPartisipan(id, peran, stReq, token);
      return response;
    } catch (e) {
      print(e);
      return ['Pendataan Gagal', false];
    }
  }

  Future<bool> editPartisipan(
    int id,
    String peran,
    String token,
  ) async {
    try {
      print('masuk provisdder');
      if (await PartisipanService().editPartisipan(
        id,
        peran,
        token,
      )) {
        print('masuk provisdder 2');
        return true;
      } else {
        print('masuk provisdder 2');
        return false;
      }
      // return true;
    } catch (e) {
      print('masuk provisdder 3');
      print(e);
      return false;
    }
  }

  Future<bool> deletePartisipan(
    int id,
    String token,
  ) async {
    try {
      if (await PartisipanService().deletePartisipan(
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
