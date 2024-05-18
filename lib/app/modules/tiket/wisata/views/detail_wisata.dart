import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/pesan_wisata.dart';

import '../../../detail_pemesanan/views/detail_pemesanan_view.dart';

class DetailWisataView extends StatefulWidget {
  @override
  _DetailWisataViewState createState() => _DetailWisataViewState();
}

class _DetailWisataViewState extends State<DetailWisataView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://asset.kompas.com/crops/epoluhVtIT10GmnGQFE2PsdUJvE=/0x203:1080x923/750x500/data/photo/2020/11/11/5fabf6158ce8a.jpg', // Replace with actual image URL
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jawa Timur Park 1',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text('4.6 (1.5 RB Review)'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time),
                      Text('Buka | Jum\'at, 08:30 - 16:30'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      Flexible(
                        child: Text(
                          'Jatim Park 1, Jl. Kartika No.2, Sisir, Kec. Batu, Kota Batu, Jawa Timur 65315, Indonesia',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Review',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
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
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Lihat Semua',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Harga Tiket',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        TicketCard(
                          title: '[Promo] Tiket Jatim Park 1 + Museum Tubuh',
                          details: 'Berlaku di tanggal terpilih',
                          price: 'Rp. 95.000',
                        ),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => DetailPesananWisataView());
                            },
                            child: Text('Pilih Tiket'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Lihat Semua',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Lokasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://via.placeholder.com/300x150'), // Replace with actual map image URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      Flexible(
                        child: Text(
                          'Jatim Park 1, Jl. Kartika No.2, Sisir, Kec. Batu, Kota Batu, Jawa Timur 65315, Indonesia',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Lihat Peta',
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

  ReviewCard({required this.rating, required this.reviewer, this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 150.h,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rating,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(reviewer),
          if (review != null) ...[
            SizedBox(height: 4),
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

  TicketCard({required this.title, required this.details, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.info, size: 16),
              SizedBox(width: 4),
              Text(details),
            ],
          ),
          SizedBox(height: 8),
          Text(
            price,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
