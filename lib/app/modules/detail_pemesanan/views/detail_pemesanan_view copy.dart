// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/detail_pemesanan/views/metode_pembayaran.dart';

import '../../../shared/url_api.dart';
import '../../search/models/user_model.dart';

class DetailPemesananViewTest extends StatefulWidget {
  final String namaTransaksi;
  final String tanggal;
  final int harga;
  final String detailTransaksi;
  const DetailPemesananViewTest({
    required this.namaTransaksi,
    required this.tanggal,
    required this.harga,
    required this.detailTransaksi,
    super.key,
  });

  @override
  State<DetailPemesananViewTest> createState() =>
      _DetailPemesananViewTestState();
}

class _DetailPemesananViewTestState extends State<DetailPemesananViewTest> {
  Future<User>? futureUser;
  late Future<Map<String, dynamic>> futureUserData;
  String? namaLengkap;
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

  Future<void> postData(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(
          UrlApi.transaction,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        print('Data berhasil dikirim');
      } else {
        print('Gagal mengirim data: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
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
      appBar: AppBar(
        title: const Text('Selesaikan Pemesananmu'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.tanggal,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          widget.namaTransaksi,
                          style: const TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.harga.toString(),
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          widget.detailTransaksi,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Detail Pemesan",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder<Map<String, dynamic>>(
                            future: futureUserData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final userData = snapshot.data!;
                                namaLengkap = userData['nama_lengkap'];
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tuan/Nyonya ${userData['nama_lengkap']}',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text('Email: ${userData['email']}'),
                                      Text('No. Telp: ${userData['no_telp']}'),
                                    ],
                                  ),
                                );
                              } else {
                                return const Text('No data available');
                              }
                            },
                          ),
                        ),
                      )),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Map<String, dynamic> data = {
                        'nama_transaksi': widget.namaTransaksi,
                        'tanggal_transaksi': widget.tanggal,
                        'harga': widget.harga,
                        "nama": namaLengkap,
                        "detail_transaksi": widget.detailTransaksi,
                      };
                      postData(data);
                      Get.to(const MetodePembayaranView());
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Lanjut Bayar",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
