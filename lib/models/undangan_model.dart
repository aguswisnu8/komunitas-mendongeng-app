import 'package:kom_mendongeng/models/user_model.dart';

class UndanganModel {
  int? id;
  int? userId;
  String? pengirim;
  String? nmKegiatan;
  String? lokasi;
  String? tgl;
  String? deskripsi;
  String? jenis;
  String? penyelenggara;
  String? contact;
  String? status;
  UserModel? user;

  UndanganModel({
    this.id,
    this.userId,
    this.pengirim,
    this.nmKegiatan,
    this.lokasi,
    this.tgl,
    this.deskripsi,
    this.jenis,
    this.penyelenggara,
    this.contact,
    this.status,
    this.user,
  });

  UndanganModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    pengirim = json['pengirim'];
    nmKegiatan = json['nm_kegiatan'];
    lokasi = json['lokasi'];
    tgl = json['tgl'];
    deskripsi = json['deskripsi'];
    jenis = json['jenis'];
    penyelenggara = json['penyelenggara'];
    contact = json['contact'];
    status = json['status'];
    user = UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'pengirim': pengirim,
      'nm_kegiatan': nmKegiatan,
      'lokasi': lokasi,
      'tgl': tgl,
      'deskripsi': deskripsi,
      'jenis': jenis,
      'penyelenggara': penyelenggara,
      'contact': contact,
      'status': status,
      'user': user?.toJson(),
    };
  }
}
