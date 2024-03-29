import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/shared/url_api.dart';

class ChatMessage {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });
}

class DetailChatView extends StatefulWidget {
  @override
  _DetailChatViewState createState() => _DetailChatViewState();
}

class _DetailChatViewState extends State<DetailChatView> {
  List<ChatMessage>? messages;
  final String token =
      '10|yo3LsTdAyrf1RAeJbjebGEiShOoZ3hH5gZ9JVfbRd51d0354'; // Ganti dengan bearer token Anda

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    final response = await http.get(
      Uri.parse('${UrlApi.getMessageById}/4/5'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        messages = responseData
            .map((json) => ChatMessage(
                  id: json['id'] as int,
                  senderId: json['sender_id'] as int,
                  receiverId: json['receiver_id'] as int,
                  message: json['message'] as String,
                  createdAt: DateTime.parse(json['created_at'] as String),
                  updatedAt: DateTime.parse(json['updated_at'] as String),
                ))
            .toList();
      });
    } else {
      throw Exception('Failed to load messages');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: messages != null
          ? ListView.builder(
              itemCount: messages?.length,
              itemBuilder: (context, index) {
                final message = messages?[index];
                final isSender =
                    message?.senderId == 4; // Change this to current user's ID
                final alignment =
                    isSender ? Alignment.centerRight : Alignment.centerLeft;
                final color = isSender ? Colors.blue : Colors.green;
                final borderRadius = isSender
                    ? BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0),
                      );

                return Align(
                  alignment: alignment,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: borderRadius,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message?.message ?? '',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          DateFormat('HH:mm').format(message!.createdAt),
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
