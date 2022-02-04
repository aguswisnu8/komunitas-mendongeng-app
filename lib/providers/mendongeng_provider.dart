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
}
