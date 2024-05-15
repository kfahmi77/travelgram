import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgram/app/modules/tiket/hotel/views/detial_hotel.dart';

class HotelView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150.h,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/hotel.png",
                  fit: BoxFit.fill,
                ),
              ),
              //text to bottom left
              Positioned(
                bottom: 10.h,
                left: 25.w,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 40.h,
                          width: 300.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Cari hotel",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                HotelTile(
                  imageUrl:
                      'https://media.istockphoto.com/id/1471856897/id/foto/ulun-danu-beratan-temple-bali-indonesia.jpg?s=1024x1024&w=is&k=20&c=vt8wVg0-iq1IT4Cmn9MGPsUk1OtxFejbi2CNAdtdIvo=',
                  name: 'Hotel Bunga',
                  location: 'Bandung',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailHotelView(),
                      ),
                    );
                  },
                ),
                HotelTile(
                  imageUrl:
                      'https://media.istockphoto.com/id/1471856897/id/foto/ulun-danu-beratan-temple-bali-indonesia.jpg?s=1024x1024&w=is&k=20&c=vt8wVg0-iq1IT4Cmn9MGPsUk1OtxFejbi2CNAdtdIvo=',
                  name: 'Hotel Pahlawan',
                  location: 'Jakarta',
                  onTap: () {},
                ),
                HotelTile(
                  imageUrl:
                      'https://media.istockphoto.com/id/1471856897/id/foto/ulun-danu-beratan-temple-bali-indonesia.jpg?s=1024x1024&w=is&k=20&c=vt8wVg0-iq1IT4Cmn9MGPsUk1OtxFejbi2CNAdtdIvo=',
                  name: 'Hotel Srikandi',
                  location: 'Surabaya',
                  onTap: () {},
                ),
                HotelTile(
                  imageUrl:
                      'https://media.istockphoto.com/id/1471856897/id/foto/ulun-danu-beratan-temple-bali-indonesia.jpg?s=1024x1024&w=is&k=20&c=vt8wVg0-iq1IT4Cmn9MGPsUk1OtxFejbi2CNAdtdIvo=',
                  name: 'Hotel Padma',
                  location: 'Sleman',
                  onTap: () {},
                ),
                HotelTile(
                  imageUrl:
                      'https://media.istockphoto.com/id/1471856897/id/foto/ulun-danu-beratan-temple-bali-indonesia.jpg?s=1024x1024&w=is&k=20&c=vt8wVg0-iq1IT4Cmn9MGPsUk1OtxFejbi2CNAdtdIvo=',
                  name: 'Hotel Kayon',
                  location: 'Bali',
                  onTap: () {},
                ),
                HotelTile(
                  imageUrl:
                      'https://media.istockphoto.com/id/1471856897/id/foto/ulun-danu-beratan-temple-bali-indonesia.jpg?s=1024x1024&w=is&k=20&c=vt8wVg0-iq1IT4Cmn9MGPsUk1OtxFejbi2CNAdtdIvo=',
                  name: 'Hotel Melia',
                  location: 'Papua',
                  onTap: () {},
                ),
                HotelTile(
                  imageUrl:
                      'https://media.istockphoto.com/id/1471856897/id/foto/ulun-danu-beratan-temple-bali-indonesia.jpg?s=1024x1024&w=is&k=20&c=vt8wVg0-iq1IT4Cmn9MGPsUk1OtxFejbi2CNAdtdIvo=',
                  name: 'Hotel Adiwana',
                  location: 'Yogyakarta',
                  onTap: () {},
                ),
                HotelTile(
                  imageUrl:
                      'https://media.istockphoto.com/id/1471856897/id/foto/ulun-danu-beratan-temple-bali-indonesia.jpg?s=1024x1024&w=is&k=20&c=vt8wVg0-iq1IT4Cmn9MGPsUk1OtxFejbi2CNAdtdIvo=',
                  name: 'Hotel Mulia',
                  location: 'Solo',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HotelTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final VoidCallback onTap;

  HotelTile({
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey.shade200,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(imageUrl,
                width: 50, height: 50, fit: BoxFit.cover),
          ),
          title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Lokasi: $location'),
        ),
      ),
    );
  }
}
