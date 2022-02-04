class UserModel {
  int? id;
  String? name;
  String? email;
  int? exp;
  String? deskripsi;
  String? alamat;
  String? medsos;
  int? active;
  String? level;
  String? profilePhotoPath;
  String? token;

  UserModel({
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
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
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
    token = json["token"];
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
      "token": token,
    };
  }
}
