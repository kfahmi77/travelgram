import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../shared/url_api.dart';
import '../models/comment_model.dart';
import 'package:http/http.dart' as http;

class CommentBottomSheet extends StatefulWidget {
  final int postId;
  final String token;

  const CommentBottomSheet({
    super.key,
    required this.postId,
    required this.token,
  });

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  late final Future<List<CommentModel>> futureComments;
  late List<CommentModel> comments = [];
  TextEditingController commentController = TextEditingController();
  Future<List<CommentModel>> fetchComments(int postId) async {
    final response = await http.get(
      Uri.parse('${UrlApi.commentFeed}/$postId/comments'),
      headers: <String, String>{
        'Authorization': 'Bearer ${widget.token}',
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

  //post comment
  Future<void> postComment(int postId, String content) async {
    final response = await http.post(
      Uri.parse('${UrlApi.commentFeed}/$postId/comments'),
      headers: <String, String>{
        'Authorization': 'Bearer ${widget.token}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'content': content,
      }),
    );
    if (response.statusCode == 201) {
      log('Comment posted');
      setState(() {
        fetchComments(postId).then((data) {
          comments = data;
        });
      });
    } else {
      log('Failed to post comment');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchComments(widget.postId).then((data) {
      setState(() {
        comments = data; // Inisialisasi daftar komentar
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            'Komentar',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final formattedDate =
                    timeago.format(comments[index].createdAt, locale: 'id');
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
                            '${UrlApi.urlStorage}${comments[index].avatar}')
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
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Tambahkan komentar...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  postComment(widget.postId, commentController.text);
                  commentController.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
