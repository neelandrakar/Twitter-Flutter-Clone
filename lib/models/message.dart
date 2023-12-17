import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  final String? id;
  final String sender;
  final String receiver;
  final String text;
  // final List<String>? imageUrls;
  // final List<String>? videoUrls;
  final DateTime sent_on;
  final bool read;
  final int d_status;
  Message({
    this.id,
    required this.sender,
    required this.receiver,
    required this.text,
    // this.imageUrls,
    // this.videoUrls,
    required this.sent_on,
    required this.read,
    required this.d_status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'sender': sender,
      'receiver': receiver,
      'text': text,
      // 'imageUrls': imageUrls,
      // 'videoUrls': videoUrls,
      'sent_on': sent_on.millisecondsSinceEpoch,
      'read': read,
      'd_status': d_status,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['_id'] as String?,
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      text: map['text'] as String,
      // imageUrls: (map['attachments']['imageUrls'] as List?)?.map((url) => url.toString()).toList(),
      // videoUrls: (map['attachments']['videoUrls'] as List?)?.map((url) => url.toString()).toList(),

      sent_on: DateTime.parse(
          map['sent_on']),
      read: map['read'] as bool,
      d_status: map['d_status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
