import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWisataView extends StatelessWidget {
  final String longtitude;
  const MapWisataView({required this.longtitude, super.key});

  @override
  Widget build(BuildContext context) {
     List<double> koordinatList = longtitude.split(',').map(double.parse).toList();
      LatLng koordinat = LatLng(koordinatList[0], koordinatList[1]);
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Map Wisata'),
      ),
      body: FlutterMap(
        options:  MapOptions(
          initialCenter: koordinat,
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
           MarkerLayer(
            markers: [
              Marker(
                point: koordinat,
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
