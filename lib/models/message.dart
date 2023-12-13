import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  final String id;
  final String sender;
  final String receiver;
  final String text;
  final DateTime sent_on;
  final int d_status;
  final bool read;
  Message({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.text,
    required this.sent_on,
    required this.d_status,
    required this.read,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'sender': sender,
      'receiver': receiver,
      'text': text,
      'sent_on': sent_on.millisecondsSinceEpoch,
      'd_status': d_status,
      'read': read,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['_id'] as String,
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      text: map['text'] as String,
      sent_on: DateTime.parse(map['sent_on']),
      d_status: map['d_status'] as int,
      read: map['read'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
