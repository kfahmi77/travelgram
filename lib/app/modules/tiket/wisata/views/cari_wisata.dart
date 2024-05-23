import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelgram/app/modules/tiket/wisata/models/tour_model.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/shared/url_api.dart';

import 'wisata_view.dart';

class TourTicketSearchView extends StatefulWidget {
  @override
  _TourTicketSearchViewState createState() => _TourTicketSearchViewState();
}

class _TourTicketSearchViewState extends State<TourTicketSearchView> {
  late Future<List<TourModel>> futureTourTickets;
  final TextEditingController _controller = TextEditingController();
  String _query = 'query';

  @override
  void initState() {
    super.initState();
    _fetchTourTickets();
  }

  void _fetchTourTickets() {
    setState(() {
      futureTourTickets = fetchTourTickets(_query);
    });
  }

  Future<List<TourModel>> fetchTourTickets(String query) async {
    final response = await http.get(Uri.parse(
        '${UrlApi.baseUrl}tour-ticket/search?nama_wisata=$query'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((ticket) => TourModel.fromJson(ticket)).toList();
    } else {
      throw Exception('Failed to load tour tickets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wisata'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Cari wisata',
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
            child: FutureBuilder<List<TourModel>>(
              future: futureTourTickets,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data found'));
                } else {
                  return FutureBuilder<List<TourModel>>(
                    future: futureTourTickets,
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
