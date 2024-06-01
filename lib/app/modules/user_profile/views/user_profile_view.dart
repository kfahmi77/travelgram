import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/feed/views/feed_view.dart';
import 'package:travelgram/app/modules/user_profile/models/feed_user_model.dart';
import 'package:travelgram/app/modules/user_profile/views/edit_user_profile.dart';
import 'package:travelgram/app/shared/url_api.dart';

import '../../search/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserProfileView extends StatefulWidget {
  final String token;
  const UserProfileView({required this.token, super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late FeedUserModel _feedUserModel;
  String? _idUser;
  bool isLoading = true;
  Future<User>? futureUser;

  @override
  void initState() {
    super.initState();
    _feedUserModel = FeedUserModel(posts: [], totalFriend: 0, totalPost: 0);
    initializeTokenAndFetchPosts();
    futureUser = fetchUser();
  }

  Future<void> initializeTokenAndFetchPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? idUser = prefs.getString('id');
    prefs.getString('avatar_url');
    prefs.getString('username');

    if (token != null && idUser != null) {
      setState(() {
        _idUser = idUser;
      });
      await fetchPosts();
    }
  }

  Future<void> fetchPosts() async {
    final response = await http.get(
      Uri.parse('${UrlApi.getFeedById}/$_idUser'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _feedUserModel = FeedUserModel.fromJson(jsonDecode(response.body));
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<User> fetchUser() async {
    final response = await http.get(Uri.parse(UrlApi.profile), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.token}',
    });

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.username);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return const CircularProgressIndicator();
          },
        ),
        centerTitle: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Flexible(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blue,
                          Color(0x006f7bf7),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "${_feedUserModel.posts.length} \n Postingan",
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Text(
                                              "${_feedUserModel.totalFriend} \n Pengikut",
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: FutureBuilder<User>(
                                  future: futureUser,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundImage: snapshot
                                                        .data!.avatar !=
                                                    null
                                                ? NetworkImage(
                                                    '${UrlApi.urlStorage}${snapshot.data!.avatar}')
                                                : NetworkImage(
                                                    UrlApi.dummyImage),
                                          ),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }

                                    return const CircularProgressIndicator();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Get.to(() => const EditProfilePage());
                          },
                          child: const Text("ubah profil"),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      //border all
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Postingan',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                            ),
                            itemCount: _feedUserModel.posts.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FullScreenImage(
                                            imageUrl: _feedUserModel
                                                        .posts[index]
                                                        .imageUrl !=
                                                    null
                                                ? '${UrlApi.urlStorage}${_feedUserModel.posts[index].imageUrl}'
                                                : _feedUserModel
                                                    .posts[index].content,
                                          ),
                                        ),
                                      );
                                    },
                                    child: _feedUserModel
                                                .posts[index].imageUrl !=
                                            null
                                        ? Image.network(
                                            '${UrlApi.urlStorage}${_feedUserModel.posts[index].imageUrl}',
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            height: 100,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                              color: Colors.blue,
                                            ),
                                            child: Center(
                                              child: Text(
                                                _feedUserModel
                                                    .posts[index].content,
                                                style: const TextStyle(
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ),
                                          ), // Placeholder widget or any alternative image widget
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
