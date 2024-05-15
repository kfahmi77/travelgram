import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgram/app/modules/detail_pemesanan/views/detail_pemesanan_view.dart';
import 'package:travelgram/app/modules/detail_pemesanan/views/metode_pembayaran.dart';

class DetailHotelView extends StatefulWidget {
  const DetailHotelView({super.key});

  @override
  _DetailHotelViewState createState() => _DetailHotelViewState();
}

class _DetailHotelViewState extends State<DetailHotelView> {
  int rentalDuration = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/hotel.png',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.blue.shade100],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Nama hotel: Siliwangi Sport\n'
                          'Lokasi: Balikpapan\n'
                          'Fasilitas: - AC, dll.\n'
                          'Jenis kamar: single/double\n'
                          'Harga: Rp1.000.000/bulan',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              'Lama sewa:',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 16),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (rentalDuration > 1) {
                                    rentalDuration--;
                                  }
                                });
                              },
                            ),
                            Text(
                              '$rentalDuration',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  rentalDuration++;
                                });
                              },
                            ),
                            SizedBox(width: 8),
                            Text(
                              'bulan',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Get.to(() => MetodePembayaranView());
                            },
                            child: Text(
                              'PESAN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
