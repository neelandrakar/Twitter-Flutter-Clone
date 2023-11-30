import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Topics {
  final int id;
  final String header;
  final String details;
  final int count;
  Topics({
    required this.id,
    required this.header,
    required this.details,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'header': header,
      'details': details,
      'count': count,
    };
  }

  factory Topics.fromMap(Map<String, dynamic> map) {
    return Topics(
      id: map['id'] as int,
      header: map['header'] as String,
      details: map['details'] as String,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Topics.fromJson(String source) =>
      Topics.fromMap(json.decode(source));
}
