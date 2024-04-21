import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      log(messages.toString());
    } else {
      throw Exception('Failed to load messages');
    }

    yield messages;
  }

  @override
  Widget build(BuildContext context) {
    // return // Generated code for this Column Widget...
    //     Column(
    //   children: [
    //     Card(
    //       color: Colors.yellow,
    //       child: Column(
    //         mainAxisSize: MainAxisSize.max,
    //         children: [
    //           Row(
    //             mainAxisSize: MainAxisSize.max,
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Column(
    //                 mainAxisSize: MainAxisSize.max,
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Row(
    //                     mainAxisSize: MainAxisSize.max,
    //                     children: [
    //                       Container(
    //                         width: 50,
    //                         height: 50,
    //                         clipBehavior: Clip.antiAlias,
    //                         decoration: BoxDecoration(
    //                           shape: BoxShape.circle,
    //                         ),
    //                         child: Image.network(
    //                           'https://picsum.photos/seed/748/600',
    //                           fit: BoxFit.cover,
    //                         ),
    //                       ),
    //                       Column(
    //                         mainAxisSize: MainAxisSize.max,
    //                         children: [
    //                           Text(
    //                             'Hello World',
    //                           ),
    //                           Text(
    //                             'Hello World',
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               Icon(
    //                 Icons.settings_outlined,
    //                 color: Colors.red,
    //                 size: 24,
    //               ),
    //             ],
    //           ),
    //           Row(
    //             mainAxisSize: MainAxisSize.max,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               ClipRRect(
    //                 borderRadius: BorderRadius.circular(8),
    //                 child: Image.network(
    //                   'https://picsum.photos/seed/279/600',
    //                   width: 300,
    //                   height: 200,
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             mainAxisSize: MainAxisSize.max,
    //             children: [
    //               Icon(
    //                 Icons.settings_outlined,
    //                 color: Colors.red,
    //                 size: 24,
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );

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

            return Card(
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
                              Container(
                                width: 50,
                                height: 50,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: message.imageUrl != null
                                    ? Image.network(
                                        '${UrlApi.urlStorage}${message.avatar!}',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        UrlApi.dummyImage,
                                        fit: BoxFit.cover,
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
                                : SizedBox()),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 24,
                      ),
                      Padding(padding: EdgeInsets.only(left: 8)),
                      Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.black,
                        size: 24,
                      ),
                      Padding(padding: EdgeInsets.only(left: 8)),
                      Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 24,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '1 menyukai',
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '${message.username} ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        message.content,
                      ),
                    ],
                  ),
                ],
              ),
            );

            return Container(
              width: double.infinity,
              height: 50.h,
              color: Colors.yellow,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (message.imageUrl != null)
                    Image.network(
                      '${UrlApi.urlStorage}${message.imageUrl!}',
                      width: 30.w,
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
