import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/features/tweet/services/tweet_services.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';
import 'package:twitter_clone/widgets/ui_constants/mainAppBar.dart';

import '../../../models/tweets.dart';
import '../../../providers/tweet_provider.dart';
import '../../../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Tweets>? allFetchedTweets = [];
  final TweetServices tweetServices = TweetServices();

  fetchAllTweets() async {

    allFetchedTweets = await tweetServices.fetchAllTweets(context: context);
    setState(() {});

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        fetchAllTweets();
    });

    //print(allFetchedTweets.toString());
  }


  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context, listen: false);
    final tweetProvider = Provider.of<TweetProvider>(context);



    return Scaffold(
      body: Center(
        child:
          ListView.builder(
            itemCount: tweetProvider.tweets.length,
              itemBuilder: (context,index){


              return TweetCard(tweets: tweetProvider.tweets[index]);
              })
      ),
    );
  }
}
