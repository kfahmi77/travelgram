import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/modules/search/models/user_model.dart';
import 'package:travelgram/app/modules/user_profile/models/feed_user_model.dart';
import 'package:travelgram/app/shared/token.dart';
import 'package:travelgram/app/shared/url_api.dart';

import '../../feed/views/feed_view.dart';

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
  late Future<FeedUserModel> profileData;

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
        throw Exception('No users found');
      }
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<FeedUserModel> fetchProfileData() async {
    final response = await http.get(
      Uri.parse('${UrlApi.getFeedById}/${widget.idUser}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
    );

    if (response.statusCode == 200) {
      return FeedUserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  @override
  void initState() {
    super.initState();
    profileData = fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<User>>(
        future: searchUsers(widget.idUser),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          } else {
            User user = snapshot.data!.first;
            return Column(
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
                                    child: const Text('Pengikut'),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      addFriend();
                                    },
                                    child: const Text('Tambah Teman'),
                                  ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0.0),
                Expanded(
                  child: FutureBuilder<FeedUserModel>(
                    future: profileData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return const Center(
                            child: Text('No profile data found'));
                      } else {
                        final profile = snapshot.data!;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Postingan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          Text(
                                            '${profile.totalPost}',
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Pengikut',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          Text(
                                            '${profile.totalFriend}',
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              height: 350.h,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 1.0,
                                    mainAxisSpacing: 1.0,
                                  ),
                                  itemCount: profile.posts.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenImage(
                                              imageUrl:
                                                  '${UrlApi.urlStorage}${profile.posts[index].imageUrl}',
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Image.network(
                                          '${UrlApi.urlStorage}/${profile.posts[index].imageUrl}',
                                          width: 200.0,
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
