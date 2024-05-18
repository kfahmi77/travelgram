import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/tiket/bus/views/bus_view.dart';
import 'package:travelgram/app/modules/tiket/hotel/views/hotel_view.dart';
import 'package:travelgram/app/modules/tiket/kereta/views/kereta_view.dart';
import 'package:travelgram/app/modules/tiket/pesawat/views/pesawat_view.dart';
import 'package:travelgram/app/modules/tiket/views/tiket_saya_view.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/wisata_view.dart';
import 'package:travelgram/app/shared/url_api.dart';
import 'package:http/http.dart' as http;

class TiketView extends StatefulWidget {
  const TiketView({super.key});

  @override
  State<TiketView> createState() => _TiketViewState();
}

class _TiketViewState extends State<TiketView> {
  Future<Map<String, dynamic>>? futureUserData;
  String? _token;
  @override
  void initState() {
    super.initState();
    initializeToken();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(
      Uri.parse(UrlApi.profile),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  void initializeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      setState(() {
        _token = token;
      });
      futureUserData = fetchUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 230.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Color(0x006f7bf7),
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                SizedBox(
                  height: 50.0,
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: futureUserData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final userData = snapshot.data!;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Hai",
                                    style: TextStyle(
                                      fontSize: 11.0,
                                    ),
                                  ),
                                  Text(
                                    userData['nama_lengkap'],
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userData['avatar'] != null
                                      ? "${UrlApi.urlStorage}${userData['avatar']}"
                                      : "${UrlApi.dummyImage}",
                                ),
                                backgroundColor: Colors.transparent,
                                radius: 30,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text('No data available');
                      }
                    },
                  ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Mau kemana hari  \nini?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                //button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: () => Get.to(() => const TiketSayaView()),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                          Text(
                            "Tiket Saya",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => const PesawatView()),
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const ImageIcon(
                          AssetImage("assets/images/plane.png"),
                          color: Colors.black,
                          size: 4.0,
                        ),
                      ),
                    ),
                    const Text(
                      "Pesawat",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(const BusView()),
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const ImageIcon(
                          AssetImage("assets/images/lucide_bus.png"),
                          color: Colors.black,
                          size: 4.0,
                        ),
                      ),
                    ),
                    const Text(
                      "Bus",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(const KeretaView()),
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const ImageIcon(
                          AssetImage("assets/images/carbon_train-speed.png"),
                          color: Colors.black,
                          size: 4.0,
                        ),
                      ),
                    ),
                    const Text(
                      "Kereta",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(HotelView()),
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const ImageIcon(
                          AssetImage("assets/images/fontisto_hotel.png"),
                          color: Colors.black,
                          size: 4.0,
                        ),
                      ),
                    ),
                    const Text(
                      "Hotel",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(const WisataView()),
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const ImageIcon(
                          AssetImage("assets/images/wisata.png"),
                          color: Colors.black,
                          size: 4.0,
                        ),
                      ),
                    ),
                    const Text(
                      "Wisata",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rekomendasi Tiket",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Lihat Semua",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 150.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://media.istockphoto.com/id/1471856897/id/foto/ulun-danu-beratan-temple-bali-indonesia.jpg?s=1024x1024&w=is&k=20&c=vt8wVg0-iq1IT4Cmn9MGPsUk1OtxFejbi2CNAdtdIvo="),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      "Candi Bali",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Bali",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                    //buat teks rating
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 12.0,
                        ),
                        Text(
                          "4.5",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Rp. 1.000.000",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 150.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://media.istockphoto.com/id/1471856897/id/foto/ulun-danu-beratan-temple-bali-indonesia.jpg?s=1024x1024&w=is&k=20&c=vt8wVg0-iq1IT4Cmn9MGPsUk1OtxFejbi2CNAdtdIvo="),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      "Candi Bali",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Bali",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                    //buat teks rating
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 12.0,
                        ),
                        Text(
                          "4.5",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Rp. 1.000.000",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
