import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/tiket/hotel/models/hotel_model.dart';
import 'package:travelgram/app/modules/tiket/hotel/views/detial_hotel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/modules/tiket/wisata/models/tour_model.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/detail_wisata.dart';
import 'package:travelgram/app/shared/url_api.dart';

import '../models/total_rating_model.dart';

class WisataView extends StatefulWidget {
  @override
  _WisataViewState createState() => _WisataViewState();
}

class _WisataViewState extends State<WisataView> {
  late Future<List<TourModel>> futureHotels;

  @override
  void initState() {
    super.initState();
    futureHotels = fetchHotels();
  }

  Future<List<TourModel>> fetchHotels() async {
    final response = await http.get(Uri.parse(UrlApi.tour));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((hotel) => TourModel.fromJson(hotel)).toList();
    } else {
      throw Exception('Failed to load hotels');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150.h,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/wisata2.png",
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 10.h,
                left: 25.w,
                child: Center(
                  child: Container(
                    height: 40.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Cari Wisata",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<TourModel>>(
              future: futureHotels,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load hotels'));
                } else {
                  List<TourModel> hotels = snapshot.data!;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 1.0,
                    ),
                    itemCount: hotels.length,
                    itemBuilder: (context, index) {
                      return CardWisata(tourModel: hotels[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardWisata extends StatefulWidget {
  final TourModel tourModel;
  const CardWisata({required this.tourModel, super.key});

  @override
  State<CardWisata> createState() => _CardWisataState();
}

class _CardWisataState extends State<CardWisata> {
  late Future<TotalRatingModel> futureRating;

  String? token;

  @override
  void initState() {
    super.initState();
    futureRating = initilaizeTokenAndFetchRating();
  }

  Future<void> initilaizeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  Future<TotalRatingModel> fetchRating() async {
    final response = await http.get(
      Uri.parse('${UrlApi.totalRating}/${widget.tourModel.id}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return TotalRatingModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load rating');
    }
  }

  Future<TotalRatingModel> initilaizeTokenAndFetchRating() async {
    await initilaizeToken();
    return await fetchRating();
  }
  var rataRating = 0.0;
  int totalReview = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(DetailWisataView(
            tourModel: widget.tourModel, rataanReview: rataRating, totalReview: totalReview,
            
          ));
          log(rataRating.toString());
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  widget.tourModel.gambar,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.tourModel.namaWisata,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(widget.tourModel.tempatWisata,
                        style: const TextStyle(color: Colors.grey)),
                   FutureBuilder<TotalRatingModel>(
      future: futureRating,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          rataRating = double.parse(snapshot.data!.averageRating!.toStringAsFixed(1));
          totalReview = snapshot.data!.totalUser!; 
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    '$rataRating',
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '/5',
                  ),
                  const SizedBox(width: 16),
                  Text('Dari $totalReview Review'),
                ],
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Belum ada review'));
        }

        return const Center(child: CircularProgressIndicator());
      },
    ),
                    Text(widget.tourModel.harga.toString(),
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
