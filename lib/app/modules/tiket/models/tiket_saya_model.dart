import 'dart:convert';

List<Transaksi> transaksiFromJson(String str) => List<Transaksi>.from(json.decode(str).map((x) => Transaksi.fromJson(x)));

String transaksiToJson(List<Transaksi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transaksi {
  int id;
  int userId;
  String namaTransaksi;
  String tanggalTransaksi;
  String harga;
  String nama;
  String detailTransaksi;
  DateTime createdAt;
  DateTime updatedAt;

  Transaksi({
    required this.id,
    required this.userId,
    required this.namaTransaksi,
    required this.tanggalTransaksi,
    required this.harga,
    required this.nama,
    required this.detailTransaksi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json["id"],
        userId: json["user_id"],
        namaTransaksi: json["nama_transaksi"],
        tanggalTransaksi: json["tanggal_transaksi"],
        harga: json["harga"],
        nama: json["nama"],
        detailTransaksi: json["detail_transaksi"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nama_transaksi": namaTransaksi,
        "tanggal_transaksi": tanggalTransaksi,
        "harga": harga,
        "nama": nama,
        "detail_transaksi": detailTransaksi,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
