// To parse this JSON data, do
//
//     final keretaModel = keretaModelFromJson(jsonString);

import 'dart:convert';

List<KeretaModel> keretaModelFromJson(String str) => List<KeretaModel>.from(json.decode(str).map((x) => KeretaModel.fromJson(x)));

String keretaModelToJson(List<KeretaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KeretaModel {
    int id;
    String namaArmada;
    String tipe;
    String asalStasiun;
    String tujuanStasiun;
    String asalDaerah;
    String tujuanDaerah;
    int harga;
    String pukulBerangkat;
    String pukulSampai;
    DateTime tanggalBerangkat;
    DateTime tanggalSampai;
    dynamic createdAt;
    dynamic updatedAt;
    String totalWaktu;

    KeretaModel({
        required this.id,
        required this.namaArmada,
        required this.tipe,
        required this.asalStasiun,
        required this.tujuanStasiun,
        required this.asalDaerah,
        required this.tujuanDaerah,
        required this.harga,
        required this.pukulBerangkat,
        required this.pukulSampai,
        required this.tanggalBerangkat,
        required this.tanggalSampai,
        required this.createdAt,
        required this.updatedAt,
        required this.totalWaktu,
    });

    factory KeretaModel.fromJson(Map<String, dynamic> json) => KeretaModel(
        id: json["id"],
        namaArmada: json["nama_armada"],
        tipe: json["tipe"],
        asalStasiun: json["asal_stasiun"],
        tujuanStasiun: json["tujuan_stasiun"],
        asalDaerah: json["asal_daerah"],
        tujuanDaerah: json["tujuan_daerah"],
        harga: json["harga"],
        pukulBerangkat: json["pukul_berangkat"],
        pukulSampai: json["pukul_sampai"],
        tanggalBerangkat: DateTime.parse(json["tanggal_berangkat"]),
        tanggalSampai: DateTime.parse(json["tanggal_sampai"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        totalWaktu: json["total_waktu"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_armada": namaArmada,
        "tipe": tipe,
        "asal_stasiun": asalStasiun,
        "tujuan_stasiun": tujuanStasiun,
        "asal_daerah": asalDaerah,
        "tujuan_daerah": tujuanDaerah,
        "harga": harga,
        "pukul_berangkat": pukulBerangkat,
        "pukul_sampai": pukulSampai,
        "tanggal_berangkat": "${tanggalBerangkat.year.toString().padLeft(4, '0')}-${tanggalBerangkat.month.toString().padLeft(2, '0')}-${tanggalBerangkat.day.toString().padLeft(2, '0')}",
        "tanggal_sampai": "${tanggalSampai.year.toString().padLeft(4, '0')}-${tanggalSampai.month.toString().padLeft(2, '0')}-${tanggalSampai.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
        "updated_at": updatedAt,
        "total_waktu": totalWaktu,
    };
}
