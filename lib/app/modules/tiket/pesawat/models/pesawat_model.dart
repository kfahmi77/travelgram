class Flight {
  final int id;
  final String namaMaskapai;
  final String bandaraKeberangkatan;
  final String bandaraTujuan;
  final String pukulBerangkat;
  final String pukulSampai;
  final String kodeKeberangkatan;
  final String kodeTujuan;
  final int hargaTiket;
  final String tanggalKeberangkatan;
  final String tanggalSampai;
  final String kodeFlight;
  final String jenisTiket;
  final String totalWaktu;

  Flight({
    required this.id,
    required this.namaMaskapai,
    required this.bandaraKeberangkatan,
    required this.bandaraTujuan,
    required this.pukulBerangkat,
    required this.pukulSampai,
    required this.kodeKeberangkatan,
    required this.kodeTujuan,
    required this.hargaTiket,
    required this.tanggalKeberangkatan,
    required this.tanggalSampai,
    required this.kodeFlight,
    required this.jenisTiket,
    required this.totalWaktu,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'],
      namaMaskapai: json['nama_maskapai'],
      bandaraKeberangkatan: json['bandara_keberangkatan'],
      bandaraTujuan: json['bandara_tujuan'],
      pukulBerangkat: json['pukul_berangkat'],
      pukulSampai: json['pukul_sampai'],
      kodeKeberangkatan: json['kode_keberangkatan'],
      kodeTujuan: json['kode_tujuan'],
      hargaTiket: json['harga_tiket'],
      tanggalKeberangkatan: json['tanggal_keberangkatan'],
      tanggalSampai: json['tanggal_sampai'],
      kodeFlight: json['kode_flight'],
      jenisTiket: json['jenis_tiket'],
      totalWaktu: json['total_waktu'],
    );
  }
}
