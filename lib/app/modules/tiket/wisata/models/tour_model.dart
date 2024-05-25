// To parse this JSON data, do
//
//     final tourModel = tourModelFromJson(jsonString);

import 'dart:convert';

List<TourModel> tourModelFromJson(String str) => List<TourModel>.from(json.decode(str).map((x) => TourModel.fromJson(x)));

String tourModelToJson(List<TourModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourModel {
    int id;
    String namaWisata;
    String tempatWisata;
    int rating;
    String gambar;
    int harga;
    String alamat;
    String jamBuka;
    String jamTutup;
    String latlong;
    dynamic createdAt;
    dynamic updatedAt;

    TourModel({
        required this.id,
        required this.namaWisata,
        required this.tempatWisata,
        required this.rating,
        required this.gambar,
        required this.harga,
        required this.alamat,
        required this.jamBuka,
        required this.jamTutup,
        required this.latlong,
        required this.createdAt,
        required this.updatedAt,
    });

    factory TourModel.fromJson(Map<String, dynamic> json) => TourModel(
        id: json["id"],
        namaWisata: json["nama_wisata"],
        tempatWisata:json["tempat_wisata"],
        rating: json["rating"],
        gambar: json["gambar"],
        harga: json["harga"],
        alamat: json["alamat"],
        jamBuka: json["jam_buka"],
        jamTutup: json["jam_tutup"],
        latlong: json["latlong"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_wisata": namaWisata,
        "tempat_wisata": tempatWisata,
        "rating": rating,
        "gambar": gambar,
        "harga": harga,
        "alamat": alamat,
        "jam_buka": jamBuka,
        "jam_tutup": jamTutup,
        "latlong": latlong,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

