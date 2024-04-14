import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/shared/token.dart';
import 'package:travelgram/app/shared/url_api.dart';

import '../models/chat_model.dart';

class ChatController extends GetxController {
  late StreamController<List<ChatMessages>> streamController;
  late List<ChatMessages> _messages;
  @override
  void onInit() {
    _messages = <ChatMessages>[];
    streamController = StreamController<List<ChatMessages>>.broadcast();
    fetchMessages();
    super.onInit();
  }

  Future<void> fetchMessages() async {
    final response = await http.get(
      Uri.parse(UrlApi.messages),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $getToken()',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<ChatMessages> messages =
          jsonData.map((json) => ChatMessages.fromJson(json)).toList();
      print(messages);
    }
  }
}
