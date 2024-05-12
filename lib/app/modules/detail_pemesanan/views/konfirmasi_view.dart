import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgram/app/shared/bottom_navigation.dart';

class KonfirmasiView extends StatelessWidget {
  const KonfirmasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Color(0x006f7bf7),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Text(
                    "Pesanan Berhasil",
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      size: 50.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          const Text(
                            "Detail Pemesanan",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 100.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Nama Pemesan"),
                                          Text("No. Telepon"),
                                          Text("Email"),
                                          Text("Alamat"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Tuan Andiva Kasih"),
                                            Text("+6281234569078"),
                                            Text("jalan andiva kasih"),
                                          ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Total Pembayaran",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                Text("Rp 2.648.700",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.offAll(() => const BottomNavBar());
                                  },
                                  child: const Text("Pesan lagi"),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.offAll(() => const BottomNavBar());
                                  },
                                  child: const Text("Lihat pesanan"),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
