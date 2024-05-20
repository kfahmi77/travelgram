import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travelgram/app/modules/detail_pemesanan/views/detail_pemesanan_view%20copy.dart';
import 'package:travelgram/app/modules/tiket/kereta/models/kereta_model.dart';


class PilihKursiKeretaView extends StatefulWidget {
  final KeretaModel busModel;
  const PilihKursiKeretaView({required this.busModel, super.key});

  @override
  createState() => _PilihKursiKeretaViewState();
}

class _PilihKursiKeretaViewState extends State<PilihKursiKeretaView> {
  List<bool> selectedSeats = List.generate(30, (index) => false);
  List<int> disabledSeats = [5, 10, 15];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    DateTime futureDate = now.add(const Duration(days: 1));

    String formattedDate =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(futureDate);
    String detailTiket =
        '${formattedDate} | ${widget.busModel.pukulBerangkat} - ${widget.busModel.pukulSampai} | ${widget.busModel.totalWaktu}';

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
                "${widget.busModel.namaArmada} | ${widget.busModel.tipe}",
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
                detailTiket,
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
              height: 300.h,
              width: double.infinity,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          if (isDisabled)
                            const Align(
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
          const Spacer(),
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
                  String namaTransaksi =
                      '${widget.busModel.asalDaerah} ke ${widget.busModel.tujuanDaerah}';
                  Get.to(() => DetailPemesananViewTest(
                        namaTransaksi: namaTransaksi,
                        tanggal: detailTiket,
                        harga: widget.busModel.harga,
                        detailTransaksi:
                            '${widget.busModel.namaArmada} | ${widget.busModel.tipe}',
                      ));
                  print(selected);
                },
                child: const Text(
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
