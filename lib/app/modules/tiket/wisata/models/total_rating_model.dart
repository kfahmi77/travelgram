// To parse this JSON data, do
//
//     final totalRatingModel = totalRatingModelFromJson(jsonString);

import 'dart:convert';

TotalRatingModel totalRatingModelFromJson(String str) => TotalRatingModel.fromJson(json.decode(str));

String totalRatingModelToJson(TotalRatingModel data) => json.encode(data.toJson());

class TotalRatingModel {
    double? totalRating;
    int? totalUser;
    double? averageRating;

    TotalRatingModel({
        required this.totalRating,
        required this.totalUser,
        required this.averageRating,
    });

    factory TotalRatingModel.fromJson(Map<String, dynamic> json) => TotalRatingModel(
        totalRating: json["total_rating"],
        totalUser: json["total_user"],
        averageRating: json["average_rating"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "total_rating": totalRating,
        "total_user": totalUser,
        "average_rating": averageRating,
    };
}
