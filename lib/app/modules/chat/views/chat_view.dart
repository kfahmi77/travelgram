import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/modules/chat/views/detail_chat_view.dart';
import 'package:travelgram/app/shared/url_api.dart';
import 'dart:convert';

import '../../search/views/search_view.dart';
import '../models/chat_model.dart';

class ChatScreenView extends StatefulWidget {
  @override
  _ChatScreenViewState createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  String? _token;
  String? _idUser;
  Stream<List<ChatMessages>>? _messagesStream;

  @override
  void initState() {
    super.initState();
    initializeToken();
  }

  void initializeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? idUser = prefs.getString('id');
    if (token != null) {
      setState(() {
        _token = token;
        _idUser = idUser;
        _messagesStream = _fetchMessagesStream();
      });
    }
  }

  Stream<List<ChatMessages>> _fetchMessagesStream() async* {
    List<ChatMessages> messages = [];
    final response = await http.get(
      Uri.parse(UrlApi.messages),
      headers: <String, String>{
        'Authorization': 'Bearer ${_token ?? ''}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      messages = jsonData.map((e) => ChatMessages.fromJson(e)).toList();
      print(messages);
    } else {
      throw Exception('Failed to load messages');
    }

    yield messages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Messages'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserSearchPage(token: _token ?? '')));
              },
            ),
          ],
        ),
        body: StreamBuilder<List<ChatMessages>>(
          stream: _messagesStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final message = snapshot.data![index];
                final formattedDate =
                    timeago.format(message.createdAt, locale: 'id');
                return InkWell(
                  onTap: () {
                    String selectedReceiverId =
                        message.receiverId.toString() == _idUser
                            ? message.senderId.toString()
                            : message.receiverId.toString();
                    print('${UrlApi.storage}${message.receiver.avatar}');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DetailChatView(
                    //       token: _token ?? '',
                    //       receiverId: selectedReceiverId,
                    //       conversationId: message.conversationId.toString(),
                    //     ),
                    //   ),
                    // );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: message.receiver.avatar != null
                          ? NetworkImage(
                              'http://192.168.14.181:8080/storage//${message.receiver.avatar}')
                          : NetworkImage(
                              'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png'),
                    ),
                    title: Text(message.message),
                    subtitle: Text(message.sender.id.toString() == _idUser
                        ? 'Saya : ${message.message}'
                        : '${message.sender.username} : ${message.message}'),
                    trailing: Text(formattedDate),
                  ),
                );
              },
            );
          },
        ));
  }
}
