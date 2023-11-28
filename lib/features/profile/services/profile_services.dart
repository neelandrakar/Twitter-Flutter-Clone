import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/http_error_handle.dart';
import '../../../constants/utils.dart';
import '../../../models/tweets.dart';
import '../../../providers/user_provider.dart';

class ProfileServices{

  Future<List<Tweets>> fetchAllMyTweets({
    required BuildContext context,
    required String userId
  }) async {

    List<Tweets> allFetchedTweets = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print('fetching...');

    try {

      Map data = {
        'userId': userId,
      };

      String jsonBody = jsonEncode(data);

      http.Response res = await http.post(
        Uri.parse('$uri/api/get-my-tweets'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonBody
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            print(res.body);

            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              allFetchedTweets
                  .add(Tweets.fromJson(jsonEncode(jsonDecode(res.body)[i])));


            }

            showSnackBar(context, 'My Tweets fetched successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }

    return allFetchedTweets;
  }

  Future<List<Tweets>> fetchAllLikedTweets({
    required BuildContext context,
    required String userId
  }) async {

    List<Tweets> allLikedTweets = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print('fetching...');

    try {

      Map data = {
        'userId': userId,
      };

      String jsonBody = jsonEncode(data);

      http.Response res = await http.post(
          Uri.parse('$uri/api/get-liked-tweets'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonBody
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            print(res.body);

            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              allLikedTweets
                  .add(Tweets.fromJson(jsonEncode(jsonDecode(res.body)[i])));


            }

            showSnackBar(context, 'Liked Tweets fetched successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }

    return allLikedTweets;
  }

  Future<List<Tweets>> fetchAllMediaTweets({
    required BuildContext context,
    required String userId
  }) async {

    List<Tweets> allFetchedTweets = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print('fetching...');

    try {

      Map data = {
        'userId': userId,
      };

      String jsonBody = jsonEncode(data);

      http.Response res = await http.post(
          Uri.parse('$uri/api/get-media-tweets'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonBody
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            print(res.body);

            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              allFetchedTweets
                  .add(Tweets.fromJson(jsonEncode(jsonDecode(res.body)[i])));


            }

            showSnackBar(context, 'Media Tweets fetched successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }

    return allFetchedTweets;
  }
}