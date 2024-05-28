import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:travelgram/app/modules/tiket/wisata/models/rating_model.dart';
import 'package:travelgram/app/modules/tiket/wisata/models/tour_model.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/lihat_review.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/map_view.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/pesan_wisata.dart';

import '../../../../shared/url_api.dart';

class DetailWisataView extends StatefulWidget {
  final TourModel tourModel;
  final double rataanReview;
  final int totalReview;
  const DetailWisataView(
      {required this.tourModel,
      required this.rataanReview,
      required this.totalReview,
      super.key});

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
                      Text(
                          '${widget.rataanReview} (${widget.totalReview} Review)'),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReviewCard(
                          idWisata: widget.tourModel.id,
                          totalReview: widget.totalReview,
                          rataanReview: widget.rataanReview)
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => ReviewPage(idTicket: widget.tourModel.id, tour: widget.tourModel));
                      },
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
                              Get.to(() => DetailPesananWisataView(
                                    tourModel: widget.tourModel,
                                  ));
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

class ReviewCard extends StatefulWidget {
  final int idWisata;
  final int totalReview;
  final double rataanReview;

  const ReviewCard(
      {super.key,
      required this.idWisata,
      required this.totalReview,
      required this.rataanReview});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  late Future<List<RatingModel>> futureRatings;

  String? token;

  @override
  void initState() {
    super.initState();
    futureRatings = initilaizeTokenAndFetchRatings();
  }

  Future<void> initilaizeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  Future<List<RatingModel>> fetchRating() async {
    final response = await http
        .get(Uri.parse('${UrlApi.getRating}/${widget.idWisata}'), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<RatingModel>((data) => RatingModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load rating');
    }
  }

  Future<List<RatingModel>> initilaizeTokenAndFetchRatings() async {
    await initilaizeToken();
    return await fetchRating();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300.w,
        height: 150.h,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: FutureBuilder<List<RatingModel>>(
          future: futureRatings,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<RatingModel> ratings = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ratings.length,
                itemBuilder: (context, index) {
                  RatingModel rating = ratings[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(rating.username),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.yellow),
                              Text(rating.rating.toString()),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(rating.review),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Failed to load rating: ${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final String title;
  final String details;
  final String price;

  const TicketCard(
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
