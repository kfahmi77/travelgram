import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
              'Bearer 10|yo3LsTdAyrf1RAeJbjebGEiShOoZ3hH5gZ9JVfbRd51d0354',
        },
      );
      print(response.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() =>  ChatScreenView(),binding: ChatBinding());
              // fetchMessages();
            },
            icon: const Icon(Icons.message),
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
