import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWisataView extends StatelessWidget {
  const MapWisataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Map Wisata'),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(-7.8617132, 112.383796),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          const MarkerLayer(
            markers: [
              Marker(
                point: LatLng(-7.8617132, 112.383796),
                width: 80.0,
                height: 80.0,
                child: Icon(
                  Icons.park,
                  size: 24.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
