// To parse this JSON data, do
//
//     final ratingModel = ratingModelFromJson(jsonString);

import 'dart:convert';

List<RatingModel> ratingModelFromJson(String str) => List<RatingModel>.from(json.decode(str).map((x) => RatingModel.fromJson(x)));

String ratingModelToJson(List<RatingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RatingModel {
    dynamic avatar;
    String username;
    double rating;
    String review;
    DateTime createdAt;

    RatingModel({
        required this.avatar,
        required this.username,
        required this.rating,
        required this.review,
        required this.createdAt,
    });

    factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        avatar: json["avatar"],
        username: json["username"],
        rating: json["rating"]?.toDouble(),
        review: json["review"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "username": username,
        "rating": rating,
        "review": review,
        "created_at": createdAt.toIso8601String(),
    };
}
