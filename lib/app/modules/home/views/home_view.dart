import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/chat/bindings/chat_binding.dart';
import 'package:travelgram/app/shared/token.dart';

import '../../../shared/url_api.dart';
import '../../chat/models/chat_model.dart';
import '../../chat/views/chat_view.dart';
import '../controllers/home_controller.dart';
import 'package:http/http.dart' as http;

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<void> fetchMessages() async {
      //get response from server with header token
      final response = await http.get(
        Uri.parse(UrlApi.messages),
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer 22|q3YD1cBW8kBgZH9SbWJqyrwVRv7DS3SGaHccWApw32d07cc6',
        },
      );
      final List<dynamic> jsonData = jsonDecode(response.body);
      List<ChatMessages> messages =
          jsonData.map((e) => ChatMessages.fromJson(e)).toList();
      print(messages);
    }

    Future<void> logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      String? token = prefs.getString('token');

      if (token != null) {
        try {
          final response = await http.post(
            Uri.parse(UrlApi.logout),
            headers: <String, String>{
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          );

          if (response.statusCode == 200) {
            await prefs.remove('token');
            await prefs.remove('id');
            print('Logout successful');
          } else {
            print('Failed to logout: ${response.statusCode}');
          }
        } catch (e) {
          print('Error during logout: $e');
        }
      } else {
        print('Token not found');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ChatScreenView(), binding: ChatBinding());
              getIdUser();
              getToken();
              // fetchMessages();
            },
            icon: const Icon(Icons.message),
          ),
          //button logout
          IconButton(
            onPressed: () {
              logout();

              Get.offAllNamed('/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
