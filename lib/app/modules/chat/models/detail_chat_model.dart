// To parse this JSON data, do
//
//     final chatMessages = chatMessagesFromJson(jsonString);

import 'dart:convert';

List<DetailChatMessages> chatMessagesFromJson(String str) =>
    List<DetailChatMessages>.from(
        json.decode(str).map((x) => DetailChatMessages.fromJson(x)));

String chatMessagesToJson(List<DetailChatMessages> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailChatMessages {
  int id;
  int conversationId;
  int senderId;
  int receiverId;
  String message;
  DateTime createdAt;
  DateTime updatedAt;
  String type;

  DetailChatMessages({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory DetailChatMessages.fromJson(Map<String, dynamic> json) =>
      DetailChatMessages(
        id: json["id"],
        conversationId: json["conversation_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "conversation_id": conversationId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type": type,
      };
}
