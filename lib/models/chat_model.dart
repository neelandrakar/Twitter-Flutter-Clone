// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  int chatId;
  int to;
  int from;
  String message;
  String chatType;
  bool toUserLoginStatus;

  ChatModel({
    required this.chatId,
    required this.to,
    required this.from,
    required this.message,
    required this.chatType,
    required this.toUserLoginStatus,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    chatId: json["chat_id"],
    to: json["to"],
    from: json["from"],
    message: json["message"],
    chatType: json["chat_type"],
    toUserLoginStatus: json["to_user_login_status"],
  );

  Map<String, dynamic> toJson() => {
    "chat_id": chatId,
    "to": to,
    "from": from,
    "message": message,
    "chat_type": chatType,
    "to_user_login_status": toUserLoginStatus,
  };
}
