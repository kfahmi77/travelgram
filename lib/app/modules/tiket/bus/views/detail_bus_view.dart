import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travelgram/app/modules/tiket/bus/models/bus_model.dart';
import 'package:travelgram/app/modules/tiket/bus/views/pilih_kursi_view.dart';

class DetailBusView extends StatelessWidget {
  final BusModel busModel;
  const DetailBusView({required this.busModel, super.key});

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) {
      return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/bis.png', // Ganti dengan URL gambar yang sesuai
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    busModel.namaArmada,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    busModel.tipe,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFeatureIcon(
                                Icons.event_seat, 'Kapasitas 8 kursi'),
                            _buildFeatureIcon(
                                Icons.settings, 'Pengaturan kursi 1-2'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFeatureIcon(Icons.ac_unit, 'Full AC'),
                            _buildFeatureIcon(Icons.airline_seat_recline_extra,
                                'Kursi recliner'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFeatureIcon(
                                Icons.accessibility_new, 'Sandaran kaki'),
                            _buildFeatureIcon(Icons.tv, 'Hiburan'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFeatureIcon(Icons.usb, 'Colokan USB'),
                            _buildFeatureIcon(
                                Icons.breakfast_dining, 'Palu pemecah kaca'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Kamu bisa pilih kursi di halaman selanjutnya',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Rute Perjalanan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildRouteInfo(
                      busModel.pukulBerangkat,
                      formatDate(busModel.tanggalBerangkat),
                      busModel.asalDaerah,
                      busModel.alamatAsal),
                  _buildRouteInfo('', busModel.totalWaktu, '', ''),
                  _buildRouteInfo(
                      busModel.pukulSampai,
                      formatDate(busModel.tanggalBerangkat),
                      busModel.tujuanDaerah,
                      busModel.alamatTujuan),
                  const SizedBox(height: 16),
                  const Text(
                    'Keberangkatan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildGuidelineList([
                    'Penumpang sudah siap setidaknya 60 menit sebelum keberangkatan di titik keberangkatan yang telah ditentukan oleh agen. Keterlambatan penumpang dapat menyebabkan tiket dibatalkan secara sepihak dan tidak mendapatkan pengembalian dana.',
                    'Pelanggan diwajibkan untuk menunjukkan e-tiket dan identitas yang berlaku (KTP/Paspor/SIM).',
                    'Pelanggan sudah divaksin lengkap vaksin COVID-19 dan memenuhi aturan protokol kesehatan sesuai dengan aturan perjalanan terbaru yang berlaku.',
                    'Waktu keberangkatan yang tertera di aplikasi adalah waktu lokal di titik keberangkatan.',
                  ]),
                  const SizedBox(height: 16),
                  const Text(
                    'Barang Bawaan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildGuidelineList([
                    'Penumpang dilarang membawa barang terlarang/ilegal dan membahayakan seperti senjata tajam, mudah terbakar, dan berbau menyengat. Penumpang bertanggung jawab penuh untuk kepemilikan tersebut dan konsekuensinya.',
                    'Ukuran dan berat bagasi per penumpang tidak melebihi aturan yang ditetapkan agen. Jika bagasi melebihi ukuran atau berat tersebut, maka penumpang diharuskan membayar biaya tambahan sesuai ketentuan agen.',
                    'Penumpang dilarang membawa hewan jenis apapun ke dalam kendaraan.',
                  ]),
                  const SizedBox(height: 16),
                  const Text(
                    'Rp. 123.000',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(PilihKursiView(
                          busModel: busModel,
                        ));
                      },
                      child: const Text('Pilih kursi'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildRouteInfo(
      String time, String date, String location, String address) {
    return Container(
      color: Colors.blue[50],
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(date),
          ],
        ),
        title:
            Text(location, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(address, maxLines: 2, overflow: TextOverflow.ellipsis),
      ),
    );
  }

  Widget _buildGuidelineList(List<String> guidelines) {
    return Container(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: guidelines.map((guideline) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text('${guidelines.indexOf(guideline) + 1}. $guideline'),
            );
          }).toList(),
        ),
      ),
    );
  }
}
