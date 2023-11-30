import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../../models/tweets.dart';
import '../../../models/user.dart';
import '../services/profile_services.dart';

class LikedTweets extends StatefulWidget {
  final User user;
  const LikedTweets({super.key, required this.user});

  @override
  State<LikedTweets> createState() => _LikedTweetsState();
}

class _LikedTweetsState extends State<LikedTweets> {

  List<Tweets>? allLikedTweets = [];
  final ProfileServices profileServices = ProfileServices();


  fetchAllTweets() async {

    allLikedTweets = await profileServices.fetchAllLikedTweets(context: context,userId: widget.user.id);
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
    return Center(
      child:  allLikedTweets!.length>0 ? ListView.builder(
          itemCount: allLikedTweets!.length,
          itemBuilder: (context,index){
            return TweetCard(tweets: allLikedTweets![index],hideRetweetedText: true,);
          }) : SpinKitRing(color: Pallete.blueColor,lineWidth: 4,size: 40,),
    );
  }
}
