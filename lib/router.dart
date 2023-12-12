import 'package:flutter/material.dart';
import 'package:twitter_clone/features/auth/screens/login_screen_one.dart';
import 'package:twitter_clone/features/auth/screens/login_screen_two.dart';
import 'package:twitter_clone/features/auth/screens/signup_screen_four.dart';
import 'package:twitter_clone/features/auth/screens/signup_screen_one.dart';
import 'package:twitter_clone/features/auth/screens/signup_screen_three.dart';
import 'package:twitter_clone/features/auth/screens/signup_screen_two.dart';
import 'package:twitter_clone/features/messeges/screens/add_new_chat.dart';
import 'package:twitter_clone/features/messeges/screens/chat_screen.dart';
import 'package:twitter_clone/features/profile/screens/profile_screen.dart';
import 'package:twitter_clone/features/tweet/screens/create_tweet_screen.dart';
import 'package:twitter_clone/features/tweet/screens/tweet_details.dart';
import 'package:twitter_clone/models/user.dart';

import 'models/tweets.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {

    case LoginScreenOne.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreenOne(),
      );

    case LoginScreenTwo.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreenTwo(),
      );

    case SignUpScreenOne.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreenOne(),
      );

    case SignUpScreenTwo.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreenTwo(),
      );

    case SignUpScreenThree.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreenThree(),
      );

    case SignUpScreenFour.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreenFour(),
      );

    case CreateTweetScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CreateTweetScreen(),
      );

    case TweetDetails.routeName:
      var tweet = routeSettings.arguments as Tweets;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => TweetDetails(tweet: tweet),
      );

    case AddNewChat.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddNewChat(),
      );

    case ProfileScreen.routeName:
      // var user = routeSettings.arguments as User;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProfileScreen(),
      );

    case ChatScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ChatScreen(),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Page not found 404!"),
            ),
          ));
  }
}