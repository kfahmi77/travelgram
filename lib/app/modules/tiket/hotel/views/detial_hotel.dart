import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travelgram/app/modules/tiket/hotel/models/hotel_model.dart';

import '../../../detail_pemesanan/views/metode_pembayaran copy.dart';

class DetailHotelView extends StatefulWidget {
  final HotelModel hotel;
  const DetailHotelView({required this.hotel, super.key});

  @override
  _DetailHotelViewState createState() => _DetailHotelViewState();
}

class _DetailHotelViewState extends State<DetailHotelView> {
  int rentalDuration = 1;
  var totalHarga = 0;
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  late String result;

  @override
  void initState() {
    super.initState();
    _updateResult();
  }

  void _updateResult() {
    DateTime now = DateTime.now();
    DateTime futureDate = now.add(Duration(days: 1));

    // Format tanggal
    String formattedDate =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(futureDate);
    // Format waktu
    String formattedTime = DateFormat('HH:mm', 'id_ID').format(now);

    // Gabungkan string sesuai kebutuhan
    setState(() {
      result = '$formattedDate | $formattedTime | $rentalDuration hari';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                widget.hotel.imageUrl,
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
                          'Nama hotel: ${widget.hotel.nama}\n'
                          'Lokasi: Balikpapan ${widget.hotel.lokasi} \n'
                          'Fasilitas: ${widget.hotel.fasilitas}\n'
                          'Jenis kamar: ${widget.hotel.jenisKamar}\n'
                          'Harga: ${currencyFormatter.format(widget.hotel.harga)}/malam',
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
                                    _updateResult();
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
                                  totalHarga =
                                      widget.hotel.harga * rentalDuration;
                                  log('total harga: $totalHarga');
                                  _updateResult();
                                });
                              },
                            ),
                            SizedBox(width: 8),
                            Text(
                              'malam',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        // buat total harga
                        Row(
                          children: [
                            Text(
                              'Total harga:',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 16),
                            Text(
                              currencyFormatter
                                  .format(widget.hotel.harga * rentalDuration),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              // Get.to(() => MetodePembayaranViewTest());
                              log(result);
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
                        SizedBox(height: 16),
                        Text(result),
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
