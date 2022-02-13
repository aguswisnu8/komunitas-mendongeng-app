import 'package:kom_mendongeng/models/user_model.dart';

class KontenModel {
  int? id;
  String? judul;
  String? gambar;
  String? link;
  String? deskripsi;
  String? jenis;
  int? status;
  int? userId;
  UserModel? user;

  KontenModel({
    this.id,
    this.judul,
    this.gambar,
    this.link,
    this.deskripsi,
    this.jenis,
    this.status,
    this.userId,
    this.user,
  });

  KontenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    gambar = json['gambar'];
    link = json['link'];
    deskripsi = json['deskripsi'];
    jenis = json['jenis'];
    status = json['status'];
    userId = json['user_id'];
    user = UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'gambar': gambar,
      'link': link,
      'deskripsi': deskripsi,
      'jenis': jenis,
      'status': status,
      'user_id': userId,
      'user': user?.toJson(),
    };
  }
}
