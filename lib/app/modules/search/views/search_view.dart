import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelgram/app/modules/search/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/shared/url_api.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({super.key});

  @override
  createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<User> _searchResults = [];

  Future<List<User>> searchUsers(String keyword) async {
    final response = await http.get(
      Uri.parse('${UrlApi.searchUser}?keyword=$keyword'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 46|o6Kzu7W0LOADhHGT2fqG6vEi5D64KVx05HyxyBf80c2ee7fd',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<User> users = data.map((user) => User.fromJson(user)).toList();
      if (users.isEmpty) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search users...',
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
            onTap: () {
              // Do something when user is tapped
            },
          );
        },
      ),
    );
  }
}
