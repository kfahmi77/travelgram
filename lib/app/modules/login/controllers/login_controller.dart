import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/login/views/login_view.dart';
import 'package:travelgram/app/shared/bottom_navigation.dart';
import 'package:travelgram/app/shared/url_api.dart';
import 'package:http/http.dart' as http;

import '../../../shared/token.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return;
    }
    final url = Uri.parse(UrlApi.login);

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
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    try {
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final token = jsonResponse['token'];
        final user = jsonResponse['user']['id'];

        await saveToken(token);
        await saveIdUser(user.toString());

        Get.offAll(const BottomNavBar(
          index: 0,
        ));
        Get.snackbar('Success', 'Login berhasil');
      } else {
        Get.back();
        Get.snackbar('Error', 'Login gagal dengan status: ${response.body}');
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Login gagal dengan error: $e');
    }
  }
}

Future<void> logout() async {
  final url = Uri.parse(UrlApi.logout);

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
      'Authorization': 'Bearer ${getToken()}',
    },
  );
  try {
    if (response.statusCode == 200) {
      await removeToken();
      Get.offAll(const LoginView());
      Get.snackbar('Success', 'Logout berhasil');
    } else {
      Get.back();
      Get.snackbar('Error', 'Logout gagal dengan status: ${response.body}');
    }
  } catch (e) {
    Get.back();
    Get.snackbar('Error', 'Logout gagal dengan error: $e');
  }
}
