// To parse this JSON data, do
//
//     final feed = feedFromJson(jsonString);

import 'dart:convert';

List<Feed> feedFromJson(String str) => List<Feed>.from(json.decode(str).map((x) => Feed.fromJson(x)));

String feedToJson(List<Feed> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Feed {
    int id;
    int userId;
    String content;
    String? imageUrl;
    DateTime createdAt;
    DateTime updatedAt;

    Feed({
        required this.id,
        required this.userId,
        required this.content,
        required this.imageUrl,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Feed.fromJson(Map<String, dynamic> json) => Feed(
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
