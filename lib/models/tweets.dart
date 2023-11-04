import 'dart:convert';

import 'package:twitter_clone/models/comments.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Tweets {
  final String id;
  final String tweeted_by;
  final String content;
  final DateTime tweeted_at;
  final List<String>? imageUrls;
  final List<String>? videoUrls;
  final List<String>? liked_by;
  final List<String>? liked_on;
  final List<String>? retweeted_by;
  final List<String>? retweeted_on;
  final List<Comments>? comments;
  final int d_status;
  final List<String>? taggedPeople;
  final String tweeted_by_name;
  final String tweeted_by_username;
  final String tweeted_by_avi;
  final int is_tweeted_by_blue;
  final int hasUserLiked;
  final int hasUserRetweeted;

  Tweets({
    required this.id,
    required this.tweeted_by,
    required this.content,
    required this.tweeted_at,
    required this.imageUrls,
    required this.videoUrls,
    required this.liked_by,
    required this.liked_on,
    required this.retweeted_by,
    required this.retweeted_on,
    required this.comments,
    required this.d_status,
    required this.taggedPeople,
    required this.tweeted_by_name,
    required this.tweeted_by_username,
    required this.tweeted_by_avi,
    required this.is_tweeted_by_blue,
    required this.hasUserLiked,
    required this.hasUserRetweeted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'tweeted_by': tweeted_by,
      'content': content,
      'tweeted_at': tweeted_at,
      'imageUrls': imageUrls,
      'videoUrls': videoUrls,
      'liked_by': liked_by,
      'liked_on': liked_on,
      'retweeted_by': retweeted_by,
      'retweeted_on': retweeted_on,
      'comments': comments!.map((x) => x.toMap()).toList(),
      'd_status': d_status,
      'taggedPeople': taggedPeople,
      'tweeted_by_name': tweeted_by_name,
      'tweeted_by_username': tweeted_by_username,
      'tweeted_by_avi': tweeted_by_avi,
      'is_tweeted_by_blue': is_tweeted_by_blue,
      'hasUserLiked': hasUserLiked,
      'hasUserRetweeted': hasUserRetweeted
    };
  }

  factory Tweets.fromMap(Map<String, dynamic> map) {
    return Tweets(
        id: map['_id'] as String,
        tweeted_by: map['tweeted_by'] as String,
        content: map['content'] as String,
        tweeted_at: DateTime.parse(
            map['tweeted_at']), // Deserialize ISO 8601 string to DateTime
        imageUrls: List<String>.from(
          (map['attachments']['imageUrls'] as List)
              .map((url) => url.toString()),
        ),
        videoUrls: List<String>.from(
          (map['attachments']['videoUrls'] as List)
              .map((url) => url.toString()),
        ),
        retweeted_by: List<String>.from(
          (map['retweets'] as List)
              .map((retweet) => retweet['retweeted_by'] as String),
        ),
        retweeted_on: List<String>.from(
          (map['retweets'] as List)
              .map((retweet) => retweet['retweeted_on'] as String),
        ),
        liked_by: List<String>.from(
          (map['likes'] as List).map((like) => like['liked_by'] as String),
        ),
        liked_on: List<String>.from(
          (map['likes'] as List).map((like) => like['liked_on'] as String),
        ),
        comments: List<Comments>.from(
            map['comments']?.map((x) => Comments.fromMap(x))),
        d_status: map['d_status'] as int,
        taggedPeople: List<String>.from((map['taggedPeople'] as List)),
        tweeted_by_name: map['tweeted_by_name'] as String,
        tweeted_by_username: map['tweeted_by_username'] as String,
        tweeted_by_avi: map['tweeted_by_avi'] as String,
        is_tweeted_by_blue: map['is_tweeted_by_blue'] as int,
        hasUserLiked: map['hasUserLiked'] as int,
        hasUserRetweeted: map['hasUserRetweeted'] as int
    );
  }

  String toJson() => json.encode(toMap());

  factory Tweets.fromJson(String source) => Tweets.fromMap(json.decode(source));
}
