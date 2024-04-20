import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/modules/chat/views/detail_chat_view.dart';
import 'package:travelgram/app/modules/feed/models/feed_model.dart';
import 'package:travelgram/app/shared/url_api.dart';
import 'dart:convert';

import '../../search/views/search_view.dart';

class FeedList extends StatefulWidget {
  const FeedList({super.key});

  @override
  createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  String? _token;
  Stream<List<Feed>>? _messagesStream;

  @override
  void initState() {
    super.initState();
    initializeToken();
  }

  void initializeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      setState(() {
        _token = token;

        _messagesStream = _fetchMessagesStream();
      });
    }
  }

  Stream<List<Feed>> _fetchMessagesStream() async* {
    List<Feed> messages = [];
    final response = await http.get(
      Uri.parse(UrlApi.getFeed),
      headers: <String, String>{
        'Authorization': 'Bearer ${_token ?? ''}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      messages = jsonData.map((e) => Feed.fromJson(e)).toList();
      print(messages);
    } else {
      throw Exception('Failed to load messages');
    }

    yield messages;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Feed>>(
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

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                message.imageUrl != null
                    ? Image.network(
                        '${UrlApi.urlStorage}${message.imageUrl!}',
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox(),
              ],
            );
          },
        );
      },
    );
  }
}
