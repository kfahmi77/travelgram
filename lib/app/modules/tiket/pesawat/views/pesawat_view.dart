import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travelgram/app/modules/tiket/pesawat/views/cari_pesawat_view.dart';

class PesawatView extends StatefulWidget {
  const PesawatView({super.key});

  @override
  State<PesawatView> createState() => _PesawatViewState();
}

class _PesawatViewState extends State<PesawatView> {
  String dropdownAsalBandara = "";
  String dropdownTujuanBandara = "";
  String selectedProvinsi = "";
  String selectedKelas = "";
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController1 = TextEditingController();
  TextEditingController _dateController2 = TextEditingController();
  int penumpang = 1;

  Map<String, String> bandaraProvinsiMap = {
    "Sultan Iskandar Muda": "Aceh",
    "Kualanamu": "Sumatera Utara",
    "Minangkabau": "Sumatera Barat",
    "Sultan Syarif Kasim II": "Riau",
    "Hang Nadim": "Kepulauan Riau",
    "Soekarno-Hatta": "Banten",
    "Halim Perdanakusuma": "DKI Jakarta",
    "Kertajati": "Jawa Barat",
    "Kulonprogo": "Daerah Istimewa Yogyakarta",
    "Juanda": "Jawa Timur",
    "I Gusti Ngurah Rai": "Bali",
    "Zainuddin Abdul Madjid": "Nusa Tenggara Barat",
    "Sultan Aji Muhammad Sulaiman": "Kalimantan Timur",
    "Sultan Hasanuddin": "Sulawesi Selatan",
    "Sam Ratulangi": "Sulawesi Utara",
    "Sentani": "Papua",
    "Komodo": "Nusa Tenggara Timur",
  };

  String formatDate(DateTime date) {
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = formatDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              Container(
                height: 150.h,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/pesawat.png",
                  fit: BoxFit.fill,
                ),
              ),
              //text to bottom left
              Positioned(
                bottom: 10.h,
                left: 10.w,
                child: Text(
                  "Pesawat",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                Text("Dari",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: dropdownAsalBandara.isEmpty ? null : dropdownAsalBandara,
                items: bandaraProvinsiMap.keys.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Row(
                      children: [
                        const Icon(Icons.airplanemode_active),
                        SizedBox(width: 10.w),
                        Expanded(
                            child:
                                Text('$value - ${bandaraProvinsiMap[value]}')),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    dropdownAsalBandara = value.toString();
                    log(dropdownAsalBandara);
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
                iconSize: 24.w,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                dropdownColor: Colors.white,
                isDense: false,
                hint: Text(
                  "Pilih Bandara",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                Text("Ke",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: dropdownTujuanBandara.isEmpty
                    ? null
                    : dropdownTujuanBandara,
                items: bandaraProvinsiMap.keys.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Row(
                      children: [
                        const Icon(Icons.airplanemode_active),
                        SizedBox(width: 10.w),
                        Expanded(
                            child:
                                Text('$value - ${bandaraProvinsiMap[value]}')),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    dropdownTujuanBandara = value.toString();
                    log(dropdownTujuanBandara);
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
                iconSize: 24.w,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                dropdownColor: Colors.white,
                isDense: false,
                hint: Text(
                  "Pilih Bandara",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Tanggal Berangkat',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: _dateController1,
                  decoration: InputDecoration(
                    hintText: 'Pillih Tanggal Berangkat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDate(context, _dateController1);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Tanggal Pulang',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: _dateController2,
                  decoration: InputDecoration(
                    hintText: 'Pilih Tanggal Pulang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDate(context, _dateController2);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Row(
              children: [
                Text(
                  "Penumpang",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  "Kelas",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Row(
              children: [
                Container(
                  width: 100.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (penumpang > 1) {
                              penumpang--;
                              log(penumpang.toString());
                            }
                          });
                        },
                      ),
                      Text(
                        "$penumpang",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            penumpang++;
                            log(penumpang.toString());
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  width: 100.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        value: selectedKelas.isEmpty ? null : selectedKelas,
                        items:
                            ["Ekonomi", "Bisnis", "First"].map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedKelas = value.toString();
                            log(selectedKelas);
                          });
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                        iconSize: 24.w,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        dropdownColor: Colors.white,
                        isDense: false,
                        hint: Text(
                          "Pilih Kelas",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CariPesawatView(
                  namaBandaraAsal: dropdownAsalBandara,
                  namaBandaraTujuan: dropdownTujuanBandara,
                  tanggal: formatDate(selectedDate),
                );
              }));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Cari Tiket",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
