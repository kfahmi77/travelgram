import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgram/app/modules/chat/views/detail_chat_view.dart';
import 'package:travelgram/app/modules/search/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/modules/search_user/views/search_user_view.dart';
import 'package:travelgram/app/shared/url_api.dart';

class UserSearchPage extends StatefulWidget {
  final String token;
  const UserSearchPage({required this.token, super.key});

  @override
  createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<User> _searchResults = [];

  Future<List<User>> searchUsers(String keyword) async {
    final response = await http.get(
      Uri.parse('http://192.168.157.181:8000/api/users/search?search=$keyword'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<User> users = data.map((user) => User.fromJson(user)).toList();
      if (users.isEmpty) {
        print(users);
        throw Exception('No users found');
      }
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  void _onSearch(String keyword) {
    if (keyword.isNotEmpty) {
      searchUsers(keyword).then((users) {
        setState(() {
          _searchResults = users;
        });
      }).catchError((error) {
        print('Error searching users: $error');
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  void _startConversation(User user) async {
    try {
      final response = await http.post(
        Uri.parse('${UrlApi.startConversation}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
        body: jsonEncode({'receiver_id': user.id}),
      );

      if (response.statusCode == 201) {
        int conversationId = jsonDecode(response.body)['conversation_id'];
        // Navigasi ke halaman chat dengan conversationId yang sesuai
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailChatView(
                conversationId: conversationId.toString(),
                receiverId: user.id.toString(),
                token: widget.token),
          ),
        );
      } else {
        throw Exception('Failed to start conversation');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    print('Token: ${widget.token}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Cari user...',
            border: InputBorder.none,
          ),
          onChanged: _onSearch,
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          User user = _searchResults[index];
          return ListTile(
              title: Text(user.username),
              subtitle: Text(user.email),
              leading: CircleAvatar(
                backgroundImage: user.avatar != null
                    ? NetworkImage('${UrlApi.urlStorage}//${user.avatar}')
                    : NetworkImage(UrlApi.dummyImage),
              ),
              onTap: () {
                Get.to(SearchUserView(
                  user: user,
                  token: widget.token,
                ));
              },
              trailing: GestureDetector(
                child: const Icon(Icons.message),
                onTap: () {
                  _startConversation(user);
                },
              ));
        },
      ),
    );
  }
}
