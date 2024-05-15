import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TiketSayaView extends StatelessWidget {
  final List<TicketData> tickets = [
    TicketData(
      title: 'Jakarta - Bandung',
      date: 'Kamis, 07 Desember 2023 | 04:30',
      price: 123000,
      quantity: 1,
      passenger: 'ANDIVA KASIH ANGGORO PUTRA',
      details: 'Jackal Holidays | Shuttle | Kuningan',
    ),
    TicketData(
      title: 'Jakarta - Bali',
      date: 'Kamis, 07 Desember 2023 | 04:30',
      price: 2648700,
      quantity: 1,
      passenger: 'ANDIVA KASIH ANGGORO PUTRA',
      details: 'Batik Air | CGK',
    ),
    TicketData(
      title: 'Jakarta - Surabaya',
      date: 'Kamis, 07 Desember 2023 | 08:20',
      price: 880000,
      quantity: 1,
      passenger: 'ANDIVA KASIH ANGGORO PUTRA',
      details: 'Argo Bromo Anggrek | GMR',
    ),
    TicketData(
      title: 'Siliwangi Sport',
      date: 'Kamis, 07 Desember 2023 | 12:30 | 1 Bulan',
      price: 1000000,
      quantity: 1,
      passenger: 'ANDIVA KASIH ANGGORO PUTRA',
      details: 'Kamar Deluks Twin',
    ),
    TicketData(
      title: 'Tiket Jatim Park 1 + Museum Tubuh',
      date: 'Kamis, 07 Desember 2023',
      price: 190000,
      quantity: 2,
      passenger: 'ANDIVA KASIH ANGGORO PUTRA',
    ),
  ];

  TiketSayaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Tiket Saya'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          return TicketCard(ticket: tickets[index]);
        },
      ),
    );
  }
}

class TicketData {
  final String title;
  final String date;
  final double price;
  final int quantity;
  final String passenger;
  final String? details;

  TicketData({
    required this.title,
    required this.date,
    required this.price,
    required this.quantity,
    required this.passenger,
    this.details,
  });
}

class TicketCard extends StatelessWidget {
  final TicketData ticket;

  TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.blue[200],
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ticket.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(ticket.date),
            SizedBox(height: 8),
            Text(
              'Rp ${ticket.price.toStringAsFixed(0)}/${ticket.quantity}',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 4),
                Text(ticket.passenger),
              ],
            ),
            if (ticket.details != null) ...[
              SizedBox(height: 8),
              Text(ticket.details!),
            ],
          ],
        ),
      ),
    );
  }
}
