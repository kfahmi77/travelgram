import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travelgram/app/modules/tiket/hotel/models/hotel_model.dart';
import 'package:travelgram/app/modules/tiket/hotel/views/detial_hotel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/shared/url_api.dart';

import 'cari_hotel.dart';

class HotelView extends StatefulWidget {
  @override
  _HotelViewState createState() => _HotelViewState();
}

class _HotelViewState extends State<HotelView> {
  late Future<List<HotelModel>> futureHotels;

  @override
  void initState() {
    super.initState();
    futureHotels = fetchHotels();
  }

  Future<List<HotelModel>> fetchHotels() async {
    final response = await http.get(Uri.parse(UrlApi.hotel));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((hotel) => HotelModel.fromJson(hotel)).toList();
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
                  "assets/images/hotel.png",
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
                        hintText: "Cari hotel",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                      onTap: () => Get.to(HotelSearchView()),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<HotelModel>>(
              future: futureHotels,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load hotels'));
                } else {
                  List<HotelModel> hotels = snapshot.data!;
                  return ListView.builder(
                    itemCount: hotels.length,
                    itemBuilder: (context, index) {
                      return HotelTile(
                        imageUrl: hotels[index].imageUrl,
                        name: hotels[index].nama,
                        location: hotels[index].lokasi,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailHotelView(
                                      hotel: hotels[index],
                                    )),
                          );
                        },
                      );
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

class HotelTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final VoidCallback onTap;

  HotelTile({
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey.shade200,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(imageUrl,
                width: 50, height: 50, fit: BoxFit.cover),
          ),
          title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Lokasi: $location'),
        ),
      ),
    );
  }
}
