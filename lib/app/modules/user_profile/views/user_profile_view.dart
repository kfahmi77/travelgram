import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/user_profile/models/feed_user_model.dart';
import 'package:travelgram/app/shared/url_api.dart';

import '../../../shared/bottom_navigation.dart';
import '../controllers/user_profile_controller.dart';
import 'package:http/http.dart' as http;

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late FeedUserModel _feedUserModel;
  String? _token;
  String? _idUser;
  String? _username;
  @override
  void initState() {
    super.initState();
    _feedUserModel = FeedUserModel(posts: [], totalFriend: 0, totalPost: 0);
    fetchPosts();
    initializeToken();
  }

  void initializeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? idUser = prefs.getString('idUser');
    String? username = prefs.getString('username');
    if (token != null) {
      setState(() {
        _token = token;
        _idUser = idUser;
        _username = username;
      });
    }
  }

  bool isLoading = true;
  Future<void> fetchPosts() async {
    final response = await http.get(
        Uri.parse(
          'http://192.168.196.181:8000/api/posts/user/1',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer 1|WuLf7ABvXHrQYKi5AYfoEXAVFizOWeggaVoBBezSb2068195'
        });
    if (response.statusCode == 200) {
      setState(() {
        _feedUserModel = FeedUserModel.fromJson(jsonDecode(response.body));
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_username'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.list),
          ),
        ],
        centerTitle: false,
      ),
      body: Column(
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
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${_feedUserModel.posts.length} \n Postingan",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Text(
                                        "${_feedUserModel.totalFriend} \n Pengikut",
                                        style: TextStyle(
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
                          child: CircleAvatar(
                            radius: 30.sp,
                            backgroundImage: NetworkImage(
                              _feedUserModel.posts.isNotEmpty
                                  ? '${UrlApi.dummyImage}'
                                  : UrlApi.dummyImage,
                            ),
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
                    onPressed: () {},
                    child: const Text("Edit Profile"),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
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
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: _feedUserModel.posts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          child: Image.network(
                            '${UrlApi.urlStorage}${_feedUserModel.posts[index].imageUrl}',
                            fit: BoxFit.cover,
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
