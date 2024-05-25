import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travelgram/app/modules/tiket/bus/views/cari_bus_view.dart';
import 'package:travelgram/app/modules/tiket/kereta/views/cari_kereta_view.dart';

class KeretaView extends StatefulWidget {
  const KeretaView({super.key});

  @override
  createState() => _KeretaViewState();
}

class _KeretaViewState extends State<KeretaView> {
  String? _selectedProvinsi1;
  String? _selectedProvinsi2;
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController1 = TextEditingController();
  TextEditingController _dateController2 = TextEditingController();
  int penumpang = 1;

  final List<String> _provinsiList = [
    ' Banten',
    'DKI Jakarta',
    'Jawa Barat',
    'Jawa Tengah',
    'DI Yogyakarta',
    'Jawa Timur'
  ];
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                SizedBox(
                  height: 150.h,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/kereta.png",
                    fit: BoxFit.fill,
                  ),
                ),
                //text to bottom left
                Positioned(
                  bottom: 10.h,
                  left: 10.w,
                  child: Text(
                    "Kereta Api",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Dari',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          hint: const Text('Pilih Provinsi'),
                          value: _selectedProvinsi1,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedProvinsi1 = newValue;
                            });
                          },
                          items: _provinsiList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Ke',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          hint: const Text('Pilih Provinsi'),
                          value: _selectedProvinsi2,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedProvinsi2 = newValue;
                            });
                          },
                          items: _provinsiList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Penumpang',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Row(
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => CariKeretaView(
                        namaAsal: _selectedProvinsi1.toString(),
                        namaTujuan: _selectedProvinsi2.toString(),
                        tanggal: formatDate(selectedDate),
                      ));
                },
                child: const Text('Cari Tiket'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
