import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travelgram/app/modules/tiket/hotel/models/hotel_model.dart';
import 'package:travelgram/app/modules/tiket/hotel/views/detial_hotel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/modules/tiket/wisata/models/tour_widget.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/detail_wisata.dart';
import 'package:travelgram/app/shared/url_api.dart';

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
class CardWisata extends StatelessWidget {
  final TourModel tourModel;
  const CardWisata({required this.tourModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(DetailWisataView(
            tourModel: tourModel,
          ));
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  tourModel.gambar,
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
                    Text(tourModel.namaWisata,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(tourModel.tempatWisata,
                        style: const TextStyle(color: Colors.grey)),
                    Text(tourModel.rating.toString()),
                    Text(tourModel.harga.toString(),
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
