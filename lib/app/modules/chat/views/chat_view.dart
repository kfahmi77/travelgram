import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:travelgram/app/shared/url_api.dart';

import '../models/chat_model.dart';
import 'detail_chat_view.dart';

class ChatScreenView extends StatelessWidget {
  final String token =
      '10|yo3LsTdAyrf1RAeJbjebGEiShOoZ3hH5gZ9JVfbRd51d0354'; // Ganti dengan bearer token Anda

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: StreamBuilder<List<Message>>(
        stream: _fetchMessagesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final message = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailChatView();
                  }));
                },
                child: ListTile(
                  title: Text(message.message),
                  subtitle: Text(
                      'Sender ID: ${message.senderId}, Receiver ID: ${message.receiverName}'),
                  trailing: Text(message.createdAt.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Stream<List<Message>> _fetchMessagesStream() async* {
    List<Message> messages = [];
    final response = await http.get(
      Uri.parse(UrlApi.messages),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      messages = jsonData.map((e) => Message.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load messages');
    }

    yield messages;
  }
}
