import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/modules/feed/models/comment_model.dart';
import 'package:travelgram/app/modules/feed/models/feed_model.dart';
import 'package:travelgram/app/shared/url_api.dart';
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;

class FeedList extends StatefulWidget {
  const FeedList({super.key});

  @override
  createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  String? _token;
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
    if (token != null) {
      setState(() {
        _token = token;
        _messagesStream = _fetchMessagesStream();
        futureComments = fetchComments(18);
      });
    }
  }

  Future<List<CommentModel>> fetchComments(int postId) async {
    final response = await http.get(
      Uri.parse('${UrlApi.commentFeed}/$postId/comments'),
      headers: <String, String>{
        'Authorization': 'Bearer ${_token ?? ''}',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      log(jsonData.toString());
      return jsonData.map((json) => CommentModel.fromJson(json)).toList();
    } else {
      log(response.reasonPhrase.toString());
      throw Exception('${response.reasonPhrase.toString()} $postId');
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

  void _showCommentBottomSheet(BuildContext context, int postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Comments',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: FutureBuilder<List<CommentModel>>(
                  future: futureComments,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<CommentModel> comments = snapshot.data!;

                      return ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final formattedDate = timeago
                              .format(comments[index].createdAt, locale: 'id');
                          return ListTile(
                            title: Text(
                              comments[index].username,
                              style: const TextStyle(
                                fontSize: 13.0,
                              ),
                            ),
                            subtitle: Text(comments[index].content),
                            leading: CircleAvatar(
                              backgroundImage: comments[index].avatar != null
                                  ? NetworkImage(
                                      '${UrlApi.urlStorage}${comments[index].avatar}',
                                    )
                                  : NetworkImage(UrlApi.dummyImage),
                            ),
                            trailing: Text(
                              formattedDate,
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      // Kirim komentar
                    },
                  ),
                ),
              ),
            ],
          ),
        );
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
                        const Icon(
                          Icons.more_horiz_outlined,
                          color: Colors.black,
                          size: 32,
                        ),
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
