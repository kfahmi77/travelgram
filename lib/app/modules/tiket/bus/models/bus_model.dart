// To parse this JSON data, do
//
//     final busModel = busModelFromJson(jsonString);

import 'dart:convert';

List<BusModel> busModelFromJson(String str) => List<BusModel>.from(json.decode(str).map((x) => BusModel.fromJson(x)));

String busModelToJson(List<BusModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusModel {
    int id;
    String namaArmada;
    String tipe;
    String asalDaerah;
    String tujuanDaerah;
    String alamatAsal;
    String alamatTujuan;
    int harga;
    String pukulBerangkat;
    String pukulSampai;
    DateTime tanggalBerangkat;
    DateTime tanggalSampai;
    dynamic createdAt;
    dynamic updatedAt;
    String totalWaktu;

    BusModel({
        required this.id,
        required this.namaArmada,
        required this.tipe,
        required this.asalDaerah,
        required this.tujuanDaerah,
        required this.alamatAsal,
        required this.alamatTujuan,
        required this.harga,
        required this.pukulBerangkat,
        required this.pukulSampai,
        required this.tanggalBerangkat,
        required this.tanggalSampai,
        required this.createdAt,
        required this.updatedAt,
        required this.totalWaktu,
    });

    factory BusModel.fromJson(Map<String, dynamic> json) => BusModel(
        id: json["id"],
        namaArmada: json["nama_armada"],
        tipe: json["tipe"],
        asalDaerah: json["asal_daerah"],
        tujuanDaerah: json["tujuan_daerah"],
        alamatAsal: json["alamat_asal"],
        alamatTujuan: json["alamat_tujuan"],
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
        "asal_daerah": asalDaerah,
        "tujuan_daerah": tujuanDaerah,
        "alamat_asal": alamatAsal,
        "alamat_tujuan": alamatTujuan,
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
