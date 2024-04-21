import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:travelgram/app/modules/search/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/shared/token.dart';
import 'package:travelgram/app/shared/url_api.dart';

class SearchUserView extends StatefulWidget {
  final User user;
  final String token;
  const SearchUserView({required this.user, required this.token, super.key});

  @override
  State<SearchUserView> createState() => _SearchUserViewState();
}

class _SearchUserViewState extends State<SearchUserView> {
  String? token;
  Future<void> addFriend() async {
    token = await getToken();
    final response = await http.post(
      Uri.parse('${UrlApi.addfriend}${widget.user.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Friend request sent');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Search'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundImage: widget.user.avatar != null
                      ? NetworkImage(
                          '${UrlApi.urlStorage}//${widget.user.avatar}')
                      : NetworkImage(UrlApi.dummyImage),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.user.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        widget.user.email,
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
                      ElevatedButton(
                        onPressed: () {
                          addFriend();
                        },
                        child: const Text('Follow'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0.0),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
}
