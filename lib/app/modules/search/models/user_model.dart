import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int id;
  String namaLengkap;
  String username;
  String email;
  String noTelp;
  dynamic emailVerifiedAt;
  dynamic avatar;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic confirmed;


  User({
    required this.id,
    required this.namaLengkap,
    required this.username,
    required this.email,
    required this.noTelp,
    required this.emailVerifiedAt,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
    required this.confirmed,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        username: json["username"],
        email: json["email"],
        noTelp: json["no_telp"],
        emailVerifiedAt: json["email_verified_at"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        confirmed: json["confirmed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_lengkap": namaLengkap,
        "username": username,
        "email": email,
        "no_telp": noTelp,
        "email_verified_at": emailVerifiedAt,
        "avatar": avatar,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "confirmed": confirmed,
      };
}
