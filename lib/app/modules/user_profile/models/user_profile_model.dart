// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    int id;
    String namaLengkap;
    String username;
    String email;
    String noTelp;
    dynamic emailVerifiedAt;
    dynamic avatar;
    DateTime createdAt;
    DateTime updatedAt;

    UserProfileModel({
        required this.id,
        required this.namaLengkap,
        required this.username,
        required this.email,
        required this.noTelp,
        required this.emailVerifiedAt,
        required this.avatar,
        required this.createdAt,
        required this.updatedAt,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        username: json["username"],
        email: json["email"],
        noTelp: json["no_telp"],
        emailVerifiedAt: json["email_verified_at"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
    };
}
