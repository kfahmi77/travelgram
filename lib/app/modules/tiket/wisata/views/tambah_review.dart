import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/url_api.dart';

class TambahReviewpage extends StatefulWidget {
  final int idTicket;
  const TambahReviewpage({required this.idTicket, super.key});

  @override
  createState() => _TambahReviewpageState();
}

class _TambahReviewpageState extends State<TambahReviewpage> {
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();

  Future<void> _submitReview() async {
    final String review = _reviewController.text;

    if (review.isNotEmpty && _rating != 0.0) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');

        final response = await http.post(
          Uri.parse(UrlApi.addRating), // Replace with your API endpoint
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'rating': _rating,
            'review': review,
            'tour_ticket_id':
                widget.idTicket, // Include the tour ticket ID if needed
          }),
        );

        if (response.statusCode == 200) {
          // Handle successful submission
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ulasan berhasil dikirim'),
            ),
          );
          // Clear the form
          _reviewController.clear();
          setState(() {
            _rating = 0.0;
          });
        } else {
          // Handle server errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Failed to submit review: ${response.reasonPhrase}'),
            ),
          );
        }
      } catch (e) {
        // Handle network errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit review: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Isi review dengan benar'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tulis Reviewmu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tulis Reviewmu disini',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitReview,
              child: const Text('Kirim Review'),
            ),
          ],
        ),
      ),
    );
  }
}
