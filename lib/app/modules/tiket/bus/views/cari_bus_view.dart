import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:travelgram/app/modules/tiket/bus/models/bus_model.dart';
import 'package:travelgram/app/modules/tiket/bus/views/detail_bus_view.dart';
import 'package:travelgram/app/modules/tiket/pesawat/views/detail_pesawat_view.dart';

import '../../../../shared/url_api.dart';

class CariBusView extends StatefulWidget {
  final String namaAsal;
  final String namaTujuan;
  final String tanggal;

  const CariBusView(
      {required this.namaAsal,
      required this.namaTujuan,
      required this.tanggal,
      super.key});

  @override
  State<CariBusView> createState() => _CariBusViewState();
}

class _CariBusViewState extends State<CariBusView> {
  late Future<List<BusModel>> futureFlights;
  @override
  void initState() {
    super.initState();
    futureFlights = fetchFlights(widget.namaAsal);
  }

  Future<List<BusModel>> fetchFlights(String bandaraKeberangkatan) async {
    final response = await http.get(
        Uri.parse('${UrlApi.bus}/search?asal_daerah=$bandaraKeberangkatan'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => BusModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load flights');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.namaAsal}  ke ${widget.namaTujuan}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        widget.tanggal,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Ubah',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            //make card list
            Expanded(
              child: FutureBuilder<List<BusModel>>(
                future: futureFlights,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CardFlight(busModel: snapshot.data![index]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardFlight extends StatelessWidget {
  final BusModel busModel;
  const CardFlight({
    required this.busModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    busModel.namaArmada,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        busModel.pukulBerangkat,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        busModel.totalWaktu,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        busModel.pukulSampai,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.red)),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 80,
                            child: VerticalDivider(color: Colors.red))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.green)),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        busModel.asalDaerah,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        busModel.tujuanDaerah,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  currencyFormatter.format(busModel.harga),
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "/ orang",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailBusView(busModel: busModel,)));
                    },
                    child: Text(
                      "Pesan",
                      style: TextStyle(fontSize: 11.sp, color: Colors.black),
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
