import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/http_error_handle.dart';
import 'package:twitter_clone/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_clone/models/tweets.dart';
import 'package:twitter_clone/providers/tweet_provider.dart';

import '../../../models/comments.dart';
import '../../../providers/user_provider.dart';

class TweetServices {
  void createATweet({
    required BuildContext context,
    required VoidCallback onSuccess,
    required String content,
    required List<File> imageFile,
    required List<File> videoFile,
  }) async {

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final cloudinary = CloudinaryPublic('dhfiapa0x', 'giscyuqg');
    List<String> imageUrls = [];
    List<String> videoUrls = [];

    for (int i = 0; i < imageFile.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(imageFile[i].path, folder: 'All Tweets'));

      imageUrls.add(res.secureUrl);
    }

    // for (int i = 0; i < imageFile.length; i++) {
    //   CloudinaryResponse res = await cloudinary
    //       .uploadFile(CloudinaryFile.fromFile(imageFile[i].path, folder: 'tweets'));
    //
    //   imageUrls.add(res.secureUrl);
    // }

    try {
      Map data = {
        'content': content,
        'imageUrl': imageUrls,
        'videoUrl': videoUrls,
      };

      String jsonBody = jsonEncode(data);

      http.Response res = await http.post(Uri.parse('$uri/api/tweet/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonBody);

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Your tweet has been posted');
            {
              Provider.of<TweetProvider>(context, listen: false).addTweet(
                  Tweets.fromJson(jsonEncode(jsonDecode(res.body))));
              print('Tweet has been added');
            }
            print('heloooooooooo');
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }
  }

  //Fetch all tweets

  Future<List<Tweets>> fetchAllTweets({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final tweetProvider = Provider.of<TweetProvider>(context, listen: false);

    List<Tweets> allFetchedTweets = [];
    print('fetching...');

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-tweets'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            print(res.body);

            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              allFetchedTweets
                  .add(Tweets.fromJson(jsonEncode(jsonDecode(res.body)[i])));
              Provider.of<TweetProvider>(context, listen: false).addTweet(Tweets.fromJson(jsonEncode(jsonDecode(res.body)[i])));


            }

            showSnackBar(context, 'Tweets fetched successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }

    return allFetchedTweets;
  }

  //Like a tweet method
  void likeATweet(
      {
        required BuildContext context,
        required Tweets tweets}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      Map data = {'id': tweets.id};

      String jsonBody = jsonEncode(data);

      http.Response res = await http.post(Uri.parse('$uri/api/like-a-tweet'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonBody);

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            print('Successfully liked');
            showSnackBar(context, 'Successfully liked');
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  Future<bool?> Function(bool)? exampleFunction = (bool? input) async {
    if (input == true) {
      return true;
    } else if (input == false) {
      return false;
    } else {
      return null;
    }
  };


  //Retweet a tweet method
  void retweetATweet(
      {required BuildContext context, required Tweets tweets,  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      Map data = {'id': tweets.id};

      String jsonBody = jsonEncode(data);

      http.Response res = await http.post(Uri.parse('$uri/api/retweet-a-tweet'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonBody);

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            //onSuccess.call();
            print(jsonEncode(res.toString()));
            showSnackBar(context, 'Successfully retweeted');
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Comments>> fetchAllComments({
    required BuildContext context,
    required String id,
  }) async {

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Comments> allFetchedComments = [];

    // print('$uri/api/get-comments/?id=$id');


    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-comments/?id=$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            print(res.body);



            // List<dynamic> commentsData = jsonDecode(res.body)["comments"];

            for (int i = 0; i < res.body.length; i++) {
            allFetchedComments.add(Comments.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }

            showSnackBar(context, 'Comments fetched successfullyyy');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }

    return allFetchedComments;
  }

  void replyToATweet({
    required BuildContext context,
    required VoidCallback onSuccess,
    required String content,
    required String id,
    required List<File> imageFile,
    required List<File> videoFile,
  }) async {

    print('called file ${imageFile.length}');

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final cloudinary = CloudinaryPublic('dhfiapa0x', 'giscyuqg');
    List<String> imageUrls = [];
    List<String> videoUrls = [];

    for (int i = 0; i < imageFile.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(imageFile[i].path, folder: 'All Tweets'));

      imageUrls.add(res.secureUrl);
    }

    // for (int i = 0; i < imageFile.length; i++) {
    //   CloudinaryResponse res = await cloudinary
    //       .uploadFile(CloudinaryFile.fromFile(imageFile[i].path, folder: 'tweets'));
    //
    //   imageUrls.add(res.secureUrl);
    // }

    try {
      Map data = {
        'content': content,
        'imageUrl': imageUrls,
        'videoUrl': videoUrls,
        'parent_tweet': id
      };

      String jsonBody = jsonEncode(data);

      print(jsonBody);

      http.Response res = await http.post(Uri.parse('$uri/api/comment/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonBody);

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {

            print(jsonDecode(res.body));
            
            showSnackBar(context, 'Reply has been added');
            List<Tweets> tweets = Provider.of<TweetProvider>(context, listen: false).tweets;
            Comments newComment = Comments.fromMap(jsonDecode(res.body));

            for(int i=0; i< tweets.length; i++){
              if(id == tweets[i].id){
                print('found');
                tweets[i].comments!.add(newComment);
                break;
              }
            }

            //This will work too
            // List<Tweet> tweets = Provider.of<TweetProvider>(context, listen: false).tweets;
            //
            // for (Tweet tweet in tweets) {
            //   if (id == tweet.id) {
            //     tweet.comments!.add(jsonDecode(res.body));
            //     break;
            //   }
            // }


            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }
  }
}
