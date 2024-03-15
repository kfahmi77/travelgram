import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();

  RxBool isPasswordMismatch = false.obs;
  RxBool isFieldEmpty = false.obs;

  Future<void> postData() async {
    final url = Uri.parse('http://192.168.242.181:80/api/register');

    isPasswordMismatch.value =
        passwordController.text != passwordRepeatController.text;
    isFieldEmpty.value = namaLengkapController.text.isEmpty ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        noTelpController.text.isEmpty ||
        passwordController.text.isEmpty;

    if (isFieldEmpty.value) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return;
    }
    if (isPasswordMismatch.value) {
      Get.snackbar('Error', 'Password tidak sama');
      return;
    }

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    final response = await http.post(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
      },
      body: {
        'nama_lengkap': namaLengkapController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'no_telp': noTelpController.text,
        'password': passwordController.text,
      },
    );

    Get.back(); 

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Success', 'Registrasi berhasil');
      Get.offNamed(Routes.LOGIN);
      print('Post successful');
      print(response.body);
    } else {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'];
        if (errors.containsKey('email')) {
          final errorMessage = errors['email'][0];
          Get.snackbar('Error', errorMessage);
          return;
        }
        if (errors.containsKey('username')) {
          final errorMessage = errors['username'][0];
          Get.snackbar('Error', errorMessage);
          return;
        }
      }
      print('Post failed with status: ${response.statusCode}');
      print(response.body);
    }
  }
}
