import 'package:kom_mendongeng/models/undangan_model.dart';

class MendongengModel {
  int? id;
  String? name;
  String? lokasi;
  String? tgl;
  String? deskripsi;
  String? gambar;
  String? partner;
  String? jenis;
  int? status;
  String? gmapLink;
  int? udanganId;
  int? expReq;
  int? stReq;
  // UndanganModel? undangan;

  MendongengModel({
    this.id,
    this.name,
    this.lokasi,
    this.tgl,
    this.deskripsi,
    this.gambar,
    this.partner,
    this.jenis,
    this.status,
    this.gmapLink,
    this.udanganId,
    this.expReq,
    this.stReq,
    // this.undangan,
  });

  MendongengModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lokasi = json['lokasi'];
    tgl = json['tgl'];
    deskripsi = json['deskripsi'];
    gambar = json['gambar'];
    partner = json['partner'];
    jenis = json['jenis'];
    status = json['status'];
    gmapLink = json['gmap_link'];
    udanganId = json['udangan_id'];
    expReq = json['exp_req'];
    stReq = json['st_req'];
    // undangan = UndanganModel.fromJson(json['undangan']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lokasi': lokasi,
      'tgl': tgl,
      'deskripsi': deskripsi,
      'gambar': gambar,
      'partner': partner,
      'jenis': jenis,
      'status': status,
      'gmap_link': gmapLink,
      'udangan_id': udanganId,
      'exp_req': expReq,
      'st_req': stReq,
      // 'undangan': undangan?.toJson(),
    };
  }
}
