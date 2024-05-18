class HotelModel {
  final int id;
  final String nama;
  final String lokasi;
  final String imageUrl;
  final String fasilitas;
  final String jenisKamar;
  final int harga;

  HotelModel({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.imageUrl,
    required this.fasilitas,
    required this.jenisKamar,
    required this.harga,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      nama: json['nama'],
      lokasi: json['lokasi'],
      imageUrl: json['image_url'],
      fasilitas: json['fasilitas'],
      jenisKamar: json['jenis_kamar'],
      harga: json['harga'],
    );
  }
}
