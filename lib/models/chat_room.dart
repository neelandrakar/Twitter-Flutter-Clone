// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

import 'package:twitter_clone/models/message.dart';

class ChatRoom {
  final String id;
  final String userOne;
  final String userTwo;
  final List<Message> messages;
  final int room_type;
  final String receiversName;
  final String receiversId;
  final String receiversUsername;
  final String receiversProfilePic;
  final int receiversBlueStatus;
  final DateTime created_on;
  final int d_status;
  ChatRoom({
    required this.id,
    required this.userOne,
    required this.userTwo,
    required this.messages,
    required this.room_type,
    required this.receiversName,
    required this.receiversId,
    required this.receiversUsername,
    required this.receiversProfilePic,
    required this.receiversBlueStatus,
    required this.created_on,
    required this.d_status
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'userOne': userOne,
      'userTwo': userTwo,
      'messages': messages.map((x) => x.toMap()).toList(),
      'roomType': room_type,
      'receiversName': receiversName,
      'receiversId': receiversId,
      'receiversUsername': receiversUsername,
      'receiversProfilePic': receiversProfilePic,
      'receiversBlueStatus': receiversBlueStatus,
      'created_on': created_on.millisecondsSinceEpoch,
      'd_status': d_status
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['_id'] as String,
      userOne: map['userOne'] as String,
      userTwo: map['userTwo'] as String,
      messages: List<Message>.from(
            map['messages']?.map((x) => Message.fromMap(x))),
      room_type: map['room_type'] as int,
      receiversName: map['receiversName'] as String,
        receiversId: map['receiversId'] as String,
      receiversUsername: map['receiversUsername'] as String,
      receiversProfilePic: map['receiversProfilePic'] as String,
      receiversBlueStatus: map['receiversBlueStatus'] as int,
      created_on: DateTime.parse(
            map['created_on']),
      d_status: map['d_status'] as int
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoom.fromJson(String source) => ChatRoom.fromMap(json.decode(source));
}
