import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/tiket/wisata/models/rating_model.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/tambah_review.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/shared/url_api.dart';

import '../models/total_rating_model.dart';

class ReviewPage extends StatelessWidget {
  final int idTicket;
  const ReviewPage({required this.idTicket, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jawa Timur Park 1'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ratings & Reviews',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() =>  TambahReviewpage(idTicket: idTicket));
                },
                child: const Text('Tulis Review anda'),
              ),
            ),
            const SizedBox(height: 16),
             RatingSummary(idTicket:idTicket),
            const SizedBox(height: 16),
             Expanded(
              child: ReviewList(idTicket: idTicket,),
            ),
          ],
        ),
      ),
    );
  }
}
class RatingSummary extends StatefulWidget {
  final int idTicket;
  const RatingSummary({required this.idTicket, super.key});

  @override
  State<RatingSummary> createState() => _RatingSummaryState();
}

class _RatingSummaryState extends State<RatingSummary> {
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
      Uri.parse('${UrlApi.totalRating}/${widget.idTicket}'),
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TotalRatingModel>(
      future: futureRating,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
        children: [
          Row(
            children: [
              Text(
                '${snapshot.data?.averageRating?.toStringAsFixed(1) ?? 0}',
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Text(
                '/5',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 16),
              Text('Dari ${snapshot.data?.totalUser ?? 0} Review'),
            ],
          ),
        ],
      )
;
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Belum ada review'));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}


class ReviewList extends StatefulWidget {
  final int idTicket;
  const ReviewList({required this.idTicket, super.key});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
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
    final response = await http.get(Uri.parse('${UrlApi.rating}/${widget.idTicket}'), headers: {
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
  String formatDate(DateTime date) {
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RatingModel>>(
      future: futureRatings,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              RatingModel rating = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                           rating.avatar != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage('${UrlApi.baseUrl}${rating.avatar!}'),
                                )
                              : const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(rating.username),
                                Text(formatDate(rating.createdAt)),
                              ],
                            ),
                            const Spacer(),
                            Text('${rating.rating}/5'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(rating.review),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Icon(Icons.thumb_up),
                            SizedBox(width: 8),
                            Text('Apakah review ini membantu?'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if(!snapshot.hasData){
          return const Center(child: Text('Belum ada review'));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
