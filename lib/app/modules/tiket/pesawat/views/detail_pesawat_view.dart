import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travelgram/app/modules/detail_pemesanan/views/detail_pemesanan_view%20copy.dart';
import 'package:travelgram/app/modules/detail_pemesanan/views/detail_pemesanan_view.dart';
import 'package:travelgram/app/modules/tiket/pesawat/models/pesawat_model.dart';

class DetailPesawatView extends StatelessWidget {
  final Flight flight;
  const DetailPesawatView({required this.flight, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    DateTime futureDate = now.add(const Duration(days: 1));

    String formattedDate =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(futureDate);
    String detailTiket =
        '${flight.kodeFlight} | ${flight.jenisTiket} | ${flight.totalWaktu} | ${formattedDate}';

    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final namaTransaksi =
        '${flight.bandaraKeberangkatan} - ${flight.bandaraTujuan}';
    final detailTransaksi = '${flight.namaMaskapai} | ${flight.jenisTiket}';
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 157.h,
              width: double.infinity,
              child: Image.asset(
                "assets/images/pesawat2.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const Row(
              children: [
                Text(
                  "Penerbangan Pilihanmu",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 500.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${flight.bandaraKeberangkatan} - ${flight.bandaraTujuan}',
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("1 Dewasa",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(flight.tanggalKeberangkatan,
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          flight.pukulBerangkat,
                                          style: const TextStyle(
                                            fontSize: 10.0,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          flight.pukulSampai,
                                          style: const TextStyle(
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1, color: Colors.red)),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              height: 200,
                                              child: VerticalDivider(
                                                  color: Colors.black))),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.green)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${flight.bandaraKeberangkatan} - ${flight.kodeKeberangkatan}",
                                          style: const TextStyle(
                                            fontSize: 10.0,
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          height: 200.h,
                                          width: 200.w,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  flight.namaMaskapai,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  detailTiket,
                                                  style: const TextStyle(
                                                    fontSize: 10.0,
                                                  ),
                                                ),
                                                const Text(
                                                  "Tiket Sudah Termasuk",
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .suitcase,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Bagasi 20kg",
                                                        style: TextStyle(
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: Row(
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .utensils,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Makanan",
                                                        style: TextStyle(
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: Row(
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons.tv,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Hiburan",
                                                        style: TextStyle(
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: Row(
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons.usb,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Colokan Listrik",
                                                        style: TextStyle(
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${flight.bandaraTujuan} - ${flight.kodeTujuan}",
                                          style: const TextStyle(
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Pilih jenis tiketmu"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70.h,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          "Bisnis",
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          '${currencyFormatter.format(flight.hargaTiket)} / orang ',
                                          style: const TextStyle(
                                              fontSize: 10.0,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              currencyFormatter
                                                  .format(flight.hargaTiket),
                                              style: const TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                          ),
                                          onPressed: () {
                                            Get.to(() =>
                                                DetailPemesananViewTest(
                                                  namaTransaksi: namaTransaksi,
                                                  tanggal: detailTiket,
                                                  harga: flight.hargaTiket,
                                                  detailTransaksi:
                                                      detailTransaksi,
                                                ));
                                          },
                                          child: const Text(
                                            "Pesan",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
