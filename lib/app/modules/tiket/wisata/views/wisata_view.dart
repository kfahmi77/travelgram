import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgram/app/modules/tiket/wisata/views/detail_wisata.dart';

class WisataView extends StatelessWidget {
  const WisataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Image.network(
                'https://asset.kompas.com/crops/epoluhVtIT10GmnGQFE2PsdUJvE=/0x203:1080x923/750x500/data/photo/2020/11/11/5fabf6158ce8a.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
                height: 200,
              ),
              const Positioned(
                bottom: 20,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jelajahi wisata di',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Batu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              //add search textfield
              Positioned(
                top: 20,
                right: 16,
                left: 16,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Cari wisata',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Kegiatan Teratas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              wisataCard(
                'Jatim Park 1',
                'Batu, Malang',
                '4,6/5 (1,5RB Review)',
                'Rp. 95.000',
                'https://asset.kompas.com/crops/epoluhVtIT10GmnGQFE2PsdUJvE=/0x203:1080x923/750x500/data/photo/2020/11/11/5fabf6158ce8a.jpg',
               ()=> Get.to(()=> DetailWisataView()),  
              ),
              wisataCard(
                'Museum Angkut',
                'Batu, Malang',
                '4,3/5 (800 Review)',
                'Rp. 95.000',
                'https://asset.kompas.com/crops/epoluhVtIT10GmnGQFE2PsdUJvE=/0x203:1080x923/750x500/data/photo/2020/11/11/5fabf6158ce8a.jpg',
               ()=> Get.to(()=> DetailWisataView()),),
              wisataCard(
                'Jatim Park 3',
                'Batu, Malang',
                '4,8/5 (2RB Review)',
                'Rp. 95.000',
                'https://asset.kompas.com/crops/epoluhVtIT10GmnGQFE2PsdUJvE=/0x203:1080x923/750x500/data/photo/2020/11/11/5fabf6158ce8a.jpg',
              ()=> Get.to(()=> DetailWisataView()),
              ),
              wisataCard(
                'Batu Night Spectacular (BNS)',
                'Batu, Malang',
                '4,4/5 (900 Review)',
                'Rp. 95.000',
                'https://asset.kompas.com/crops/epoluhVtIT10GmnGQFE2PsdUJvE=/0x203:1080x923/750x500/data/photo/2020/11/11/5fabf6158ce8a.jpg',
                ()=> Get.to(()=> DetailWisataView()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget wisataCard(String title, String location, String review, String price,
      String imageUrl, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(location, style: const TextStyle(color: Colors.grey)),
                    Text(review),
                    Text(price,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
