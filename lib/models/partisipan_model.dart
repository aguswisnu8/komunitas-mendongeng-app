import 'package:kom_mendongeng/models/mendongeng_model.dart';
import 'package:kom_mendongeng/models/user_model.dart';

class PartisipanModel {
  int? id;
  int? userId;
  int? mendongengId;
  String? peran;
  UserModel? user;
  MendongengModel? mendongeng;

  PartisipanModel({
    this.id,
    this.userId,
    this.mendongengId,
    this.peran,
    this.user,
    this.mendongeng,
  });

  PartisipanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mendongengId = json['mendongeng_id'];
    peran = json['peran'];
    user = UserModel.fromJson(json['user']);
    mendongeng = MendongengModel.fromJson(json['mendongeng']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'mendongeng_id': mendongengId,
      'peran': peran,
      'user': user?.toJson(),
      'mendongeng': mendongeng?.toJson(),
    };
  }
}
