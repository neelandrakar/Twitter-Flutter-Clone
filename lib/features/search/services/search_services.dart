import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:twitter_clone/constants/http_error_handle.dart';
import 'package:twitter_clone/models/topics.dart';
import 'package:twitter_clone/models/tweets.dart';

import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';


class SearchServices{

  Future<List<Topics>> fetchForYouTopics({
    required BuildContext context
}) async {

    List<Topics> allFetchedForYouTopics = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print('hellloooo');


    try{
      http.Response res = await http.get(
          Uri.parse('$uri/api/fetch-for-you-topics'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: (){

            print(res.body);

            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              allFetchedForYouTopics
                  .add(Topics.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          }
      );
    }catch(e){
      showSnackBar(context, e.toString());
    }

    return allFetchedForYouTopics;

}

  Future<List<Topics>> fetchSportsTopics({
    required BuildContext context
  }) async {

    List<Topics> allFetchedSportsTopics = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print('hellloooo');


    try{
      http.Response res = await http.get(
        Uri.parse('$uri/api/sports-topics'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: (){

            print(res.body);

            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              allFetchedSportsTopics
                  .add(Topics.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          }
      );
    }catch(e){
      showSnackBar(context, e.toString());
    }

    return allFetchedSportsTopics;

  }

  Future<List<Tweets>> fetchTopTweets({
    required BuildContext context,
    required String searchedQuery
  }) async {

    List<Tweets> allFetchedTopTweets = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print('hellloooo');


    try{
      http.Response res = await http.get(
        Uri.parse('$uri/api/search/top/?searchedQuery=$searchedQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: (){

            print(res.body);

            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              allFetchedTopTweets
                  .add(Tweets.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          }
      );
    }catch(e){
      showSnackBar(context, e.toString());
    }

    return allFetchedTopTweets;

  }
}