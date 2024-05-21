import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/tambah_review.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

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
                  Get.to(() => const TambahReviewpage());
                },
                child: const Text('Tulis Review anda'),
              ),
            ),
            const SizedBox(height: 16),
            const RatingSummary(),
            const SizedBox(height: 16),
            Expanded(
              child: ReviewList(),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingSummary extends StatelessWidget {
  const RatingSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Text(
                '4.6',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Text(
                '/5',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(width: 16),
              Text('Dari 1,5 RB Review'),
            ],
          ),
        ],
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  final List<Map<String, dynamic>> reviews = [
    {
      'user': 'User 1',
      'date': '1 Des 2023',
      'review': 'Pelayanan baik, tempat oke',
      'rating': 5.0
    },
    {
      'user': 'User 2',
      'date': '1 Des 2023',
      'review': 'Banyak wahana seru,',
      'rating': 5.0
    },
    {
      'user': 'User 3',
      'date': '1 Des 2023',
      'review': 'Good, cocok untuk main bersama teman',
      'rating': 4.5
    },
    {
      'user': 'User 4',
      'date': '1 Des 2023',
      'review': 'Pelayanan baik, tempat oke',
      'rating': 4.0
    },
    {
      'user': 'User 5',
      'date': '1 Des 2023',
      'review': 'Pelayanan baik, tempat oke',
      'rating': 4.3
    },
    {
      'user': 'User 6',
      'date': '1 Des 2023',
      'review': 'Pelayanan baik, tempat oke',
      'rating': 4.3
    },
  ];

  ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
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
                      const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(review['user']),
                          Text(review['date']),
                        ],
                      ),
                      const Spacer(),
                      Text('${review['rating']}/5'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(review['review']),
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
  }
}
