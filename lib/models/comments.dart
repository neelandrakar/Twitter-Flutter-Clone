import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Comments {
  final String id;
  final String commented_by;
  final String content;
  final String parent_tweet;
  final DateTime commented_at;
  final List<String>? imageUrls;
  final List<String>? videoUrls;
  final List<String>? liked_by;
  final List<String>? liked_on;
  final List<String>? retweeted_by;
  final List<String>? retweeted_on;
  final int d_status;
  final List<String>? taggedPeople;
  // final int commented_by_blue_status;
  final String commented_by_name;
  // final String commented_by_username;
  final String commented_by_avi;

  //final String tweeted_by_name;
  //final String tweeted_by_username;
  //final String tweeted_by_avi;
  //final int is_tweeted_by_blue;
  //final int hasUserLiked;
  //final int hasUserRetweeted;

  Comments({
    required this.id,
    required this.commented_by,
    required this.content,
    required this.commented_at,
    required this.parent_tweet,
    required this.imageUrls,
    required this.videoUrls,
    required this.liked_by,
    required this.liked_on,
    required this.retweeted_by,
    required this.retweeted_on,
    required this.d_status,
    // required this.commented_by_blue_status,
    required this.taggedPeople,
    required this.commented_by_name,
    // required this.commented_by_username,
    required this.commented_by_avi,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'commented_by': commented_by,
      'content': content,
      'commented_at': commented_at,
      'parent_tweet': parent_tweet,
      'imageUrls': imageUrls,
      'videoUrls': videoUrls,
      'liked_by': liked_by,
      'liked_on': liked_on,
      'retweeted_by': retweeted_by,
      'retweeted_on': retweeted_on,
      'd_status': d_status,
      // 'commented_by_blue_status': commented_by_blue_status,
      'taggedPeople': taggedPeople,
      'commented_by_name': commented_by_name,
      // 'commented_by_username': commented_by_username,
      'commented_by_avi': commented_by_avi,
    };
  }

  factory Comments.fromMap(Map<String, dynamic> map) {
    return Comments(
      id: map['_id'] as String,
      commented_by: map['commented_by'] as String,
      parent_tweet: map['parent_tweet'] as String,
      content: map['content'] as String,
      commented_at: DateTime.parse(
          map['commented_at']), // Deserialize ISO 8601 string to DateTime
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
      d_status: map['d_status'] as int,
      taggedPeople: List<String>.from((map['taggedPeople'] as List)),
      commented_by_name: map['commented_by_name'] as String,
      // commented_by_username: map['commented_by_username'] as String,
      // commented_by_blue_status: map['commented_by_blue_status'] as int,
      commented_by_avi: map['commented_by_avi'] as String,

    );
  }

  String toJson() => json.encode(toMap());

  factory Comments.fromJson(String source) => Comments.fromMap(json.decode(source));
}