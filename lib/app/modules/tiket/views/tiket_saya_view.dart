import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/shared/url_api.dart';

import '../models/tiket_saya_model.dart';

class TiketSayaView extends StatefulWidget {
  const TiketSayaView({Key? key}) : super(key: key);

  @override
  State<TiketSayaView> createState() => _TiketSayaViewState();
}

class _TiketSayaViewState extends State<TiketSayaView> {
  List<Transaksi> tickets = [];
  String? _token;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    initializeToken();
  }

  void initializeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      setState(() {
        _token = token;
      });
      await fetchTransaksi();
    } else {
      setState(() {
        isLoading = false;
        errorMessage = 'Token tidak ditemukan';
      });
    }
  }

  Future<void> fetchTransaksi() async {
    try {
      final response = await http.get(
        Uri.parse(UrlApi.transaction),
        headers: <String, String>{
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          tickets = data.map((json) => Transaksi.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load transaksi';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load transaksi: $e';
      });
    }
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
        title: const Text('Tiket Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : tickets.isEmpty
                  ? const Center(child: Text('Tidak ada data transaksi'))
                  : ListView.builder(
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        return TicketCard(ticket: tickets[index]);
                      },
                    ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final Transaksi ticket;

  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.blue[200],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ticket.namaTransaksi,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(ticket.tanggalTransaksi),
            const SizedBox(height: 8),
            Text(
              'Total: ${ticket.harga}',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 4),
                Text(ticket.nama),
              ],
            ),
            if (ticket.detailTransaksi.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(ticket.detailTransaksi),
            ],
          ],
        ),
      ),
    );
  }
}
