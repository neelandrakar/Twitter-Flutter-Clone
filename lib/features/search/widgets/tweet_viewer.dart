import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twitter_clone/features/search/services/search_services.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';

import '../../../models/tweets.dart';
import '../../../theme/pallete.dart';

class TweetViewer extends StatefulWidget {
   List<Tweets> allTweets;
   TweetViewer({super.key, required this.allTweets});

  @override
  State<TweetViewer> createState() => _TweetViewerState();
}

class _TweetViewerState extends State<TweetViewer> {

  @override
  Widget build(BuildContext context) {

    print(widget.allTweets.length);


    return Center(
      child: widget.allTweets.length>0 ?
      ListView.builder(
        itemCount: widget.allTweets.length,
        itemBuilder: (context,index) {
          return TweetCard(tweets: widget.allTweets[index], hideRetweetedText: true,);
        }
    ) : SpinKitRing(color: Pallete.blueColor,lineWidth: 4,size: 40,),


    );
  }
}
