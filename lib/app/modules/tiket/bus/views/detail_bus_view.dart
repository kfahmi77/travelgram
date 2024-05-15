import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travelgram/app/modules/tiket/bus/views/pilih_kursi_view.dart';

class DetailBusView extends StatelessWidget {
  const DetailBusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 150.h,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/bis.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 150),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jackal holidays',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Shuttle',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildFeatureIcons(),
                      SizedBox(height: 10),
                      _buildRouteInfo(),
                      SizedBox(height: 10),
                      _buildSectionTitle('Keberangkatan'),
                      _buildList([
                        'Penumpang sudah siap setidaknya 60 menit sebelum keberangkatan di titik keberangkatan yang telah ditentukan oleh agen. Keterlambatan penumpang dapat menyebabkan tiket dibatalkan secara sepihak dan tidak mendapatkan pengembalian dana.',
                        'Pelanggan diwajibkan untuk menunjukkan e-tiket dan identitas yang berlaku (KTP/Paspor/SIM).',
                        'Pelanggan sudah divaksin lengkap vaksin COVID-19 dan memenuhi aturan protokol kesehatan sesuai dengan aturan perjalanan terbaru yang berlaku.',
                        'Waktu keberangkatan yang tertera di aplikasi adalah waktu lokal di titik keberangkatan.',
                      ]),
                      SizedBox(height: 10),
                      _buildSectionTitle('Barang Bawaan'),
                      _buildList([
                        'Penumpang dilarang membawa barang terlarang/ilegal dan membahayakan seperti senjata tajam, mudah terbakar, dan berbau menyengat. Penumpang bertanggung jawab penuh untuk kepemilikan tersebut dan konsekuensinya.',
                        'Ukuran dan berat bagasi per penumpang tidak melebihi aturan yang ditetapkan agen. Jika bagasi melebihi ukuran atau berat tersebut, maka penumpang diharuskan membayar biaya tambahan sesuai ketentuan agen.',
                        'Penumpang dilarang membawa hewan jenis apapun ke dalam kendaraan.',
                      ]),
                      SizedBox(height: 20),
                      _buildFooter(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcons() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFeatureIcon(
              Icons.airline_seat_recline_extra, 'Kapasitas 8 kursi'),
          _buildFeatureIcon(Icons.ac_unit, 'Full AC'),
          _buildFeatureIcon(Icons.add, 'Sandaran kaki'),
          _buildFeatureIcon(Icons.usb, 'Colokan USB'),
          _buildFeatureIcon(Icons.chair, 'Pengaturan kursi 1-2'),
          _buildFeatureIcon(Icons.chair, 'Kursi recliner'),
          _buildFeatureIcon(Icons.tv, 'Hiburan'),
          _buildFeatureIcon(
              Icons.four_g_plus_mobiledata_sharp, 'Palu pemecah kaca'),
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        Text(
          label,
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRouteInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rute Perjalanan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.lightBlue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text('05:15\n07 Des', textAlign: TextAlign.center),
                  SizedBox(height: 4),
                  Text('07:15\n07 Des', textAlign: TextAlign.center),
                ],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kuningan'),
                  Text('Gedung Pusat Perfilman Jl. HR Rasuna Said Kav C-...'),
                  SizedBox(height: 8),
                  Text('Dipatiukur'),
                  Text('Jl. Dipati Ukur No.40, Lebakgede, Kecamata...'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(item),
        );
      }).toList(),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          'Rp. 123.000',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Get.to(() => const PilihKursiView());
          },
          child: Text('Pilih kursi'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
