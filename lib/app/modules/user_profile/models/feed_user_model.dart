// To parse this JSON data, do
//
//     final feedUserModel = feedUserModelFromJson(jsonString);

import 'dart:convert';

FeedUserModel feedUserModelFromJson(String str) => FeedUserModel.fromJson(json.decode(str));

String feedUserModelToJson(FeedUserModel data) => json.encode(data.toJson());

class FeedUserModel {
    List<Post> posts;
    int totalPost;
    int totalFriend;

    FeedUserModel({
        required this.posts,
        required this.totalPost,
        required this.totalFriend,
    });

    factory FeedUserModel.fromJson(Map<String, dynamic> json) => FeedUserModel(
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        totalPost: json["total_post"],
        totalFriend: json["total_friend"],
    );

    Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "total_post": totalPost,
        "total_friend": totalFriend,
    };
}

class Post {
    int id;
    int userId;
    String content;
    String imageUrl;
    DateTime createdAt;
    DateTime updatedAt;

    Post({
        required this.id,
        required this.userId,
        required this.content,
        required this.imageUrl,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        userId: json["user_id"],
        content: json["content"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "content": content,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
