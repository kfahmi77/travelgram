import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/chat/bindings/chat_binding.dart';
import 'package:travelgram/app/modules/feed/views/feed_view.dart';
import 'package:travelgram/app/shared/token.dart';

import '../../../shared/url_api.dart';
import '../../chat/views/chat_view.dart';
import '../../search/models/user_model.dart';
import '../controllers/home_controller.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? _token;

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      String? token = prefs.getString('token');

      if (token != null) {
        try {
          final response = await http.post(
            Uri.parse(UrlApi.logout),
            headers: <String, String>{
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          );

          if (response.statusCode == 200) {
            await prefs.remove('token');
            await prefs.remove('id');
            await prefs.remove('username');
            await prefs.remove('avatar');
            print('Logout successful');
          } else {
            print('Failed to logout: ${response.statusCode}');
          }
        } catch (e) {
          print('Error during logout: $e');
        }
      } else {
        print('Token not found');
      }
    }

    Future<List<dynamic>> fetchData() async {
      final response = await http.get(
        Uri.parse(UrlApi.getRequestFriend),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    }

    Future<void> acceptFriendRequest(int idFriend) async {
      final response = await http.post(
        Uri.parse('${UrlApi.acceptFriend}$idFriend'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to post data');
      }
    }
    // Future<List<User>> getFriendRequest() async {
    //   final response = await http.get(
    //     Uri.parse(UrlApi.getRequestFriend),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Authorization': 'Bearer $_token',
    //     },
    //   );

    //   if (response.statusCode == 200) {
    //     List<dynamic> data = jsonDecode(response.body);
    //     List<User> users = data.map((user) => User.fromJson(user)).toList();
    //     print(data);

    //     return users;
    //   } else {
    //     throw Exception('Failed to load users');
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Travelgram',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const ChatScreenView(), binding: ChatBinding());
              getIdUser();
              getToken();
              // fetchMessages();
            },
            icon: const Icon(Icons.message, color: Colors.white),
          ),
          //button logout
          IconButton(
            onPressed: () {
              logout();

              Get.offAllNamed('/login');
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
          //icon notification
          IconButton(
            onPressed: () {
              //create notification dialog
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Notifkasi'),
                    content: SizedBox(
                        width: double.maxFinite, // Set lebar maksimum konten
                        child: FutureBuilder<List<dynamic>>(
                          future: fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  var user = snapshot.data?[index];
                                  return Card(
                                    elevation: 1,
                                    child: ListTile(
                                      title: Text(user['username']),
                                      subtitle: const Text(
                                          'mengirim pertemanan ke anda'),
                                      trailing: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                        onPressed: () {
                                          acceptFriendRequest(user['id']);
                                          setState(() {
                                            snapshot.data?.removeAt(index);
                                          });
                                        },
                                        child: const Text("Tambah"),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        )),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      body: const FeedList(),
    );
  }
}
