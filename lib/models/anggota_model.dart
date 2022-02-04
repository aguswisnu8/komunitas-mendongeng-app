class AnggotaModel {
  int? id;
  String? name;
  String? email;
  int? exp;
  String? deskripsi;
  String? medsos;
  String? alamat;
  int? active;
  String? level;
  String? profilePhotoPath;

  AnggotaModel({
    this.id,
    this.name,
    this.email,
    this.exp,
    this.deskripsi,
    this.alamat,
    this.medsos,
    this.active,
    this.level,
    this.profilePhotoPath,
  });

  AnggotaModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    exp = json["exp"];
    deskripsi = json["deskripsi"];
    medsos = json["medsos"];
    alamat = json["alamat"];
    active = json["active"];
    level = json["level"];
    profilePhotoPath = json["profile_photo_path"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "exp": exp,
      "deskripsi": deskripsi,
      "medsos": medsos,
      "alamat": alamat,
      "active": active,
      "level": level,
      "profile_photo_path": profilePhotoPath,
    };
  }
}
