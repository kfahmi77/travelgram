class Message {
  final int id;
  final int senderId;
  final int receiverId;
  final String receiverName;
  final String message;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.receiverName,
    required this.message,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      receiverName: json['receiver_name'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      
    );
  }
}