import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travelgram/app/modules/detail_pemesanan/views/konfirmasi_view.dart';

class MetodePembayaranView extends StatelessWidget {
  const MetodePembayaranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Metode Pembayaran"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Metode Pembayaran Saya",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/cc.png",
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.fill,
                  ),
                  onTap: () {
                    Get.to(() => const KonfirmasiView());
                  },
                  title: const Text("Tambah Pembayaran"),
                  trailing: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 24.0,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Metode Pembayaran Lainnya",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/bni.png",
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.fill,
                  ),
                  title: const Text("BNI"),
                  trailing: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 24.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/bri.png",
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.fill,
                  ),
                  title: const Text("BRI"),
                  trailing: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 24.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/btn.png",
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.fill,
                  ),
                  title: const Text("BTN"),
                  trailing: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 24.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/mandiri.png",
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.fill,
                  ),
                  title: const Text("Mandiri"),
                  trailing: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 24.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/linkaja.png",
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.fill,
                  ),
                  title: const Text("Link Aja"),
                  trailing: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 24.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: const ListTile(
                  title: Text("Retail"),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 24.0,
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
