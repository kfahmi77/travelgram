// To parse this JSON data, do
//
//     final chatMessages = chatMessagesFromJson(jsonString);

import 'dart:convert';

List<ChatMessages> chatMessagesFromJson(String str) => List<ChatMessages>.from(
    json.decode(str).map((x) => ChatMessages.fromJson(x)));

String chatMessagesToJson(List<ChatMessages> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatMessages {
  int conversationId;
  int senderId;
  int receiverId;
  String message;
  DateTime createdAt;
  String type;
  Receiver receiver;
  Sender sender;

  ChatMessages({
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
    required this.type,
    required this.receiver,
    required this.sender,
  });

  factory ChatMessages.fromJson(Map<String, dynamic> json) => ChatMessages(
        conversationId: json["conversation_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        type: json["type"],
        receiver: Receiver.fromJson(json["receiver"]),
        sender: Sender.fromJson(json["sender"]),
      );

  Map<String, dynamic> toJson() => {
        "conversation_id": conversationId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "created_at": createdAt.toIso8601String(),
        "type": type,
        "receiver": receiver.toJson(),
      };
}

class Receiver {
  int id;
  String username;
  dynamic avatar;

  Receiver({
    required this.id,
    required this.username,
    required this.avatar,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        username: json["username"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar": avatar,
      };
}

class Sender {
  int id;
  String username;

  Sender({
    required this.id,
    required this.username,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}
