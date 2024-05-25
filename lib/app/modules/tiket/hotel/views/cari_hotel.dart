import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelgram/app/modules/tiket/hotel/models/hotel_model.dart';
import 'package:travelgram/app/modules/tiket/wisata/models/tour_model.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/shared/url_api.dart';

import 'detial_hotel.dart';
import 'hotel_view.dart';

class HotelSearchView extends StatefulWidget {
  @override
  _HotelSearchViewState createState() => _HotelSearchViewState();
}

class _HotelSearchViewState extends State<HotelSearchView> {
  late Future<List<HotelModel>> futureHotel;
  final TextEditingController _controller = TextEditingController();
  String _query = 'query';

  @override
  void initState() {
    super.initState();
    _fetchTourTickets();
  }

  void _fetchTourTickets() {
    setState(() {
      futureHotel = fetchHotel(_query);
    });
  }

  Future<List<HotelModel>> fetchHotel(String query) async {
    final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}hotel/search?nama=$query'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((ticket) => HotelModel.fromJson(ticket)).toList();
    } else {
      throw Exception('Failed to load tour tickets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Cari Hotel',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _query = _controller.text;
                      _fetchTourTickets();
                    });
                  },
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  _query = value;
                  _fetchTourTickets();
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<HotelModel>>(
              future: futureHotel,
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
