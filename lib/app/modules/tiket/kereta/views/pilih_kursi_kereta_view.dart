import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../detail_pemesanan/views/detail_pemesanan_view.dart';

class PilihKursiKeretaView extends StatefulWidget {
  const PilihKursiKeretaView({super.key});

  @override
  createState() => _PilihKursiKeretaViewState();
}

class _PilihKursiKeretaViewState extends State<PilihKursiKeretaView> {
  List<bool> selectedSeats = List.generate(30, (index) => false);
  List<int> disabledSeats = [5, 10, 15]; // List of disabled seats

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200.h,
            width: double.infinity,
            child: Image.asset(
              "assets/images/kereta.png",
              fit: BoxFit.fill,
            ),
          ),
          Row(
            children: [
              Text(
                "Jackal holidays | Shuttle",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Kam, 07 Des | 05:15 - 07:15 | 2j",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
              ),
              Text(
                "Dipilih",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.sp,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
              ),
              Text(
                "Tersedia",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.sp,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
              ),
              Text(
                "Tidak tersedia",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 300.0,
              width: double.infinity,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of seats in a row
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: selectedSeats.length,
                itemBuilder: (context, index) {
                  bool isDisabled = disabledSeats.contains(index);
                  return GestureDetector(
                    onTap: isDisabled
                        ? null
                        : () {
                            setState(() {
                              selectedSeats[index] = !selectedSeats[index];
                            });
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDisabled
                            ? Colors.red
                            : (selectedSeats[index]
                                ? Colors.green
                                : Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              'Kursi ${index + 1}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          if (isDisabled)
                            Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  List<int> selected = [];
                  for (int i = 0; i < selectedSeats.length; i++) {
                    if (selectedSeats[i]) {
                      selected.add(i + 1);
                    }
                  }
                  Get.to(() => const DetailPemesananView());
                  print(selected);
                },
                child: Text(
                  "Lanjut ke Form Pemesanan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0.h)
        ],
      ),
    );
  }
}
