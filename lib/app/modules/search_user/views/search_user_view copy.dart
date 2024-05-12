import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:travelgram/app/modules/search/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/shared/token.dart';
import 'package:travelgram/app/shared/url_api.dart';

class SearchUserViewTest extends StatefulWidget {
  final int idUser;
  final String token;
  const SearchUserViewTest(
      {required this.idUser, required this.token, super.key});

  @override
  State<SearchUserViewTest> createState() => _SearchUserViewTestState();
}

class _SearchUserViewTestState extends State<SearchUserViewTest> {
  String? token;
  Future<void> addFriend() async {
    token = await getToken();
    final response = await http.post(
      Uri.parse('${UrlApi.addfriend}${widget.idUser}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Permintaan pertemanan berhasil dikirim');
    } else {
      final responseData = jsonDecode(response.body);
      if (responseData['message'] == 'Friend request already sent') {
        Get.snackbar('Info', 'Pengajuan pertemanan sudah dikirim');
      } else {
        Get.snackbar('Error', 'Failed to send friend request');
      }
    }
  }

  Future<List<User>> searchUsers(int idUser) async {
    final response = await http.get(
      Uri.parse('${UrlApi.getUserById}?search=$idUser'),
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
      print(data);
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: searchUsers(widget.idUser),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          User user = snapshot.data!.first;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: user.avatar != null
                            ? NetworkImage(
                                '${UrlApi.urlStorage}//${user.avatar}')
                            : NetworkImage(UrlApi.dummyImage),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              user.username,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 8.0),
                            const Row(
                              children: <Widget>[
                                Icon(Icons.location_on),
                                SizedBox(width: 4.0),
                                Text('Location'),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            user.confirmed != null
                                ? ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Teman'),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      addFriend();
                                    },
                                    child: const Text('Tambah Teman'),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0.0),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                    ),
                    itemBuilder: (context, index) {
                      return Image.network(
                        "https://images.unsplash.com/flagged/photo-1559502867-c406bd78ff24?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=685&q=80",
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      );
                    },
                    itemCount: 9,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
