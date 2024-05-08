import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/modules/feed/models/comment_model.dart';
import 'package:travelgram/app/modules/feed/models/feed_model.dart';
import 'package:travelgram/app/modules/feed/views/comment_feed.dart';
import 'package:travelgram/app/shared/bottom_navigation.dart';
import 'package:travelgram/app/shared/url_api.dart';
import 'dart:convert';

class FeedList extends StatefulWidget {
  const FeedList({super.key});

  @override
  createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  String? _token;
  String? _idUser;

  bool _isliked = false;
  Stream<List<Feed>>? _messagesStream;
  Future<List<CommentModel>>? futureComments;

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
      log(messages.toString());
    } else {
      throw Exception('Failed to load messages');
    }

    yield messages;
  }

  Future<http.Response> deleteAlbum(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('${UrlApi.deleteFeed}/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${_token ?? ''}',
      },
    );

    return response;
  }

  void _showCommentBottomSheet(BuildContext context, int postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CommentBottomSheet(postId: postId, token: _token!);
      },
    );
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

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: message.avatar != null
                                        ? Image.network(
                                            '${UrlApi.urlStorage}${message.avatar!}',
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            UrlApi.dummyImage,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 8.w)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message.username,
                                    ),
                                    const Text(
                                      'Lokasi',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        PopupMenuButton<int>(
                          icon: const Icon(
                            Icons.more_horiz_outlined,
                            color: Colors.black,
                            size: 32,
                          ),
                          itemBuilder: (context) => [
                            _idUser == message.userId.toString()
                                ? const PopupMenuItem(
                                    value: 1,
                                    child: Text("Hapus Postingan"),
                                  )
                                : const PopupMenuItem(
                                    value: 2,
                                    child: Text("Laporkan Postingan"),
                                  ),
                          ],
                          onSelected: (value) {
                            if (value == 1) {
                              deleteAlbum(message.id.toString());
                              Get.offAll(const BottomNavBar());
                            } else if (value == 2) {
                              print("Option 2 selected");
                            }
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        children: [
                          Text(
                            message.content,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: message.imageUrl != null
                                  ? Image.network(
                                      '${UrlApi.urlStorage}${message.imageUrl!}',
                                      width: 300.w,
                                      height: 200.h,
                                      fit: BoxFit.cover,
                                    )
                                  : const SizedBox()),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          icon: Icon(
                            _isliked ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              _isliked = !_isliked;
                            });
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(left: 8)),
                        IconButton(
                          onPressed: () {
                            _showCommentBottomSheet(context, message.id);
                          },
                          icon: const Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.send,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    const Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '1 menyukai',
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    const Divider(
                      height: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '${message.username} ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
