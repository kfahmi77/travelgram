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
                  Spacer(),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100.0,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.check,
                          size: 100.0,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Get.offAll(() => const BottomNavBar(
                                  index: 0,
                                ));
                          },
                          child: const Text("Pesan lagi"),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.offAll(() => const BottomNavBar(
                                  index: 1,
                                ));
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
          ],
        ),
      ),
    ));
  }
}
