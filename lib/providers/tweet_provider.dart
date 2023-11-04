import 'package:flutter/cupertino.dart';
import 'package:twitter_clone/models/tweets.dart';

class TweetProvider extends ChangeNotifier{

  List<Tweets> tweets = [
    // Tweets(
    //     id: '',
    //     tweeted_by: '',
    //     content: '',
    //     tweeted_at: DateTime.now(),
    //     imageUrls: [],
    //     videoUrls: [],
    //     liked_by: [],
    //     liked_on: [],
    //     retweeted_by: [],
    //     retweeted_on: [],
    //     comments: [],
    //     d_status: 0,
    //     taggedPeople: [],
    //     tweeted_by_name: '',
    //     tweeted_by_username: '',
    //     tweeted_by_avi: '',
    //     is_tweeted_by_blue: 0,
    //     hasUserLiked: 0,
    //     hasUserRetweeted: 0)
  ];


  void addTweet(Tweets tweet){
    tweets.add(tweet);
    notifyListeners();
  }

  void removeTweets(Tweets tweet){
    tweets.remove(tweet);
    notifyListeners();
  }

}