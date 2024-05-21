import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travelgram/app/modules/tiket/wisata/models/tour_widget.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/map_view.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/pesan_wisata.dart';

import '../../../detail_pemesanan/views/detail_pemesanan_view.dart';

class DetailWisataView extends StatefulWidget {
  final TourModel tourModel;
  const DetailWisataView({required this.tourModel, super.key});

  @override
  _DetailWisataViewState createState() => _DetailWisataViewState();
}

class _DetailWisataViewState extends State<DetailWisataView> {
  String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.tourModel.gambar,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.tourModel.namaWisata}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      Text('${widget.tourModel.rating} (1.5 RB Review)'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time),
                      Text(
                          'Buka |  ${formatTime(widget.tourModel.jamBuka)} - ${formatTime(widget.tourModel.jamTutup)}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Flexible(
                        child: Text(
                          '${widget.tourModel.alamat}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Review',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReviewCard(
                          rating: '4,6/5', reviewer: 'Dari 1.5 RB Review'),
                      ReviewCard(
                          rating: '5,0/5',
                          reviewer: 'Budi',
                          review:
                              'Good, cocok untuk main bersama teman, banyak wahana seru'),
                      ReviewCard(
                          rating: '5,0/5',
                          reviewer: 'Dwi',
                          review: 'Pelayanan baik, tempat oke'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Lihat Semua',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Harga Tiket',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        TicketCard(
                          title: widget.tourModel.namaWisata,
                          details: 'Berlaku di tanggal terpilih',
                          price: 'Rp. ${widget.tourModel.harga}',
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => DetailPesananWisataView());
                            },
                            child: const Text('Pilih Tiket'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Lihat Semua',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Lokasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Flexible(
                        child: Text(
                          widget.tourModel.alamat,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(MapWisataView(
                          longtitude: widget.tourModel.latlong,
                        ));
                      },
                      child: const Text('Lihat Peta',
                          style: TextStyle(color: Colors.blue)),
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
}

class ReviewCard extends StatelessWidget {
  final String rating;
  final String reviewer;
  final String? review;

  ReviewCard(
      {super.key, required this.rating, required this.reviewer, this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 150.h,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rating,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(reviewer),
          if (review != null) ...[
            const SizedBox(height: 4),
            Text(review!),
          ],
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final String title;
  final String details;
  final String price;

  TicketCard(
      {super.key,
      required this.title,
      required this.details,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.info, size: 16),
              const SizedBox(width: 4),
              Text(details),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
