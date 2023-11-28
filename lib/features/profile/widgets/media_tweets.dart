import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';

import '../../../models/tweets.dart';
import '../../../models/user.dart';
import '../../../theme/pallete.dart';
import '../services/profile_services.dart';

class MediaTweets extends StatefulWidget {
  final User user;
  const MediaTweets({super.key, required this.user});

  @override
  State<MediaTweets> createState() => _MediaTweetsState();
}

class _MediaTweetsState extends State<MediaTweets> {

  List<Tweets>? allMediaTweets = [];
  final ProfileServices profileServices = ProfileServices();


  fetchAllTweets() async {

    allMediaTweets = await profileServices.fetchAllMediaTweets(context: context,userId: widget.user.id);
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
      child: allMediaTweets!.length>0 ? ListView.builder(
          itemCount: allMediaTweets!.length,
          itemBuilder: (context,index){
            return TweetCard(tweets: allMediaTweets![index]);
          }) : SpinKitRing(color: Pallete.blueColor,lineWidth: 4,size: 40,),
    );
  }
}
