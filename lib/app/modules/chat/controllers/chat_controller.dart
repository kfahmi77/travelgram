import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/shared/url_api.dart';

import '../models/chat_model.dart';

class ChatController extends GetxController {
  late StreamController<List<Message>> streamController;
  late List<Message> _messages;
  @override
  void onInit() {
    _messages = <Message>[];
    streamController = StreamController<List<Message>>.broadcast();
    fetchMessages();
    super.onInit();
  }

  Future<void> fetchMessages() async {
    final response = await http.get(
      Uri.parse(UrlApi.messages),
      headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer 10|yo3LsTdAyrf1RAeJbjebGEiShOoZ3hH5gZ9JVfbRd51d0354',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<Message> messages =
          jsonData.map((e) => Message.fromJson(e)).toList();
      print(messages);
    }
  }
}
