import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travelgram/app/modules/detail_pemesanan/views/detail_pemesanan_view.dart';
import 'package:travelgram/app/modules/detail_pemesanan/views/konfirmasi_view.dart';
import 'package:travelgram/app/modules/detail_pemesanan/views/metode_pembayaran.dart';
import 'package:travelgram/app/modules/tiket/wisata/models/tour_model.dart';

import '../../../detail_pemesanan/views/detail_pemesanan_view copy.dart';

class DetailPesananWisataView extends StatefulWidget {
  final TourModel tourModel;
  const DetailPesananWisataView({required this.tourModel, super.key});

  @override
  _DetailPesananWisataViewState createState() =>
      _DetailPesananWisataViewState();
}

class _DetailPesananWisataViewState extends State<DetailPesananWisataView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _ticketCount = 1;
  int _maxTickets = 10;
  late int _ticketPrice;

  

  @override
  void initState() {
    super.initState();
    _ticketPrice = widget.tourModel.harga;
  }
   String formatDate(DateTime date) {
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
  }

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
        title: Text('Detail Pesanan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectedPackageCard(
                title: '[Promo] ${widget.tourModel.namaWisata}',
                price: _ticketPrice,
                details: 'Berlaku di tanggal terpilih',
              ),
              SizedBox(height: 16),
              Text(
                'Tanggal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              CalendarWidget(
                calendarFormat: _calendarFormat,
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
              ),
              SizedBox(height: 16),
              TicketCounter(
                count: _ticketCount,
                maxTickets: _maxTickets,
                onIncrement: () {
                  setState(() {
                    if (_ticketCount < _maxTickets) {
                      _ticketCount++;
                    }
                  });
                },
                onDecrement: () {
                  setState(() {
                    if (_ticketCount > 1) {
                      _ticketCount--;
                    }
                  });
                }, price: _ticketPrice,
              ),
              SizedBox(height: 16),
              OrderSummaryCard(
                selectedDate: _selectedDay,
                totalPrice: _ticketCount * _ticketPrice,
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => DetailPemesananViewTest(namaTransaksi: widget.tourModel.namaWisata, tanggal: formatDate(DateTime.parse(_selectedDay.toString())), harga: widget.tourModel.harga, detailTransaksi: 'jumlah tiket ${_ticketCount}',));
                  },
                  child: Text('PESAN'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedPackageCard extends StatelessWidget {
  final String title;
  final int price;
  final String details;

  SelectedPackageCard({super.key, 
    required this.title,
    required this.price,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paket Terpilih',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Rp. ${price.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.info, size: 16),
                SizedBox(width: 4),
                Text(details),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime, DateTime) onDaySelected;
  final void Function(CalendarFormat) onFormatChanged;

  CalendarWidget({super.key, 
    required this.calendarFormat,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onFormatChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TableCalendar(
        locale: 'id_ID',
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        calendarFormat: calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(selectedDay, day);
        },
        onDaySelected: onDaySelected,
        onFormatChanged: onFormatChanged,
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.blue[100],
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(color: Colors.black),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(Icons.arrow_back_ios),
          rightChevronIcon: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}

class TicketCounter extends StatelessWidget {
  final int count;
  final int maxTickets;
  final price;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  TicketCounter({super.key, 
    required this.count,
    required this.maxTickets,
    required this.price,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah Tiket',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp. ${(count * price ).toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: onDecrement,
                    ),
                    Text('$count'),
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: onIncrement,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4),
            Text('Maks. $maxTickets tiket'),
          ],
        ),
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {
  final DateTime? selectedDate;
  final int totalPrice;

  OrderSummaryCard({super.key, required this.selectedDate, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
 String formatDate(DateTime date) {
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
  }
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tanggal'),
                Text(
                  selectedDate != null
                      ? formatDate(DateTime.parse(selectedDate.toString()))
                      : '-',
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text('Total Harga'),
                Text(
                  'Rp. ${totalPrice.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
