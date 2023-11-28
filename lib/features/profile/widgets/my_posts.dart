import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../../models/tweets.dart';
import '../../../models/user.dart';
import '../services/profile_services.dart';

class MyPosts extends StatefulWidget {
  final User user;
  const MyPosts({super.key, required this.user});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {

  List<Tweets>? allMyTweets = [];
  final ProfileServices profileServices = ProfileServices();


  fetchAllTweets() async {

    allMyTweets = await profileServices.fetchAllMyTweets(context: context,userId: widget.user.id);
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
      child: allMyTweets!.length>0 ?
      ListView.builder(
          itemCount: allMyTweets!.length,
          itemBuilder: (context,index){
            return TweetCard(tweets: allMyTweets![index]);
          }) : SpinKitRing(color: Pallete.blueColor,lineWidth: 4,size: 40,),
    );
  }
}
