import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/home/screens/home_screen.dart';
import 'package:twitter_clone/features/tweet/screens/tweet_details.dart';
import 'package:twitter_clone/features/tweet/widgets/hashtag_text.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_icon_button.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../models/tweets.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/ui_constants/assets_constants.dart';
import '../screens/reply_screen.dart';
import '../services/tweet_services.dart';

class TweetCard extends StatefulWidget {
  final Tweets tweets;
  final bool hideRetweetedText;
  TweetCard({super.key, required this.tweets, this.hideRetweetedText = false});

  @override
  State<TweetCard> createState() => _TweetCardState();
}

class _TweetCardState extends State<TweetCard> {

  ImageProvider<Object> backgroundImageProvider = AssetImage(AssetsConstants.searchIcon);

  void openReplyScreen(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      enableDrag: false,
      context: context,
      isScrollControlled: true, // Makes the sheet full screen
      builder: (BuildContext context) {
        return ReplyScreen(tweet: widget.tweets);
      },
    );
  }

  final TweetServices tweetServices = TweetServices();


  void retweetATweet(){

    tweetServices.retweetATweet(
      context: context,
      tweets: widget.tweets,
    );
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {

    String userProfilePic = widget.tweets.tweeted_by_avi;
    int totalComments = widget.tweets.comments!.length;
    int totalRetweets = widget.tweets.retweeted_by!.length;
    int totalLikes = widget.tweets.liked_by!.length;
    int totalViews = totalComments + totalRetweets + totalLikes;
    Color retweetButtonColor = Pallete.blueColor;
    String textDemo = 'hii';

    bool isLiked = widget.tweets.hasUserLiked==1;
    bool isRetweeted = widget.tweets.hasUserRetweeted==1;


    void likeATweet(){

      tweetServices.likeATweet(context: context, tweets: widget.tweets);

    }

    void changeRetweetStatus() {
      if (isRetweeted) {
        setState(() {
          isRetweeted = false;
          totalRetweets = totalRetweets-1;
        });
      } else {
        setState(() {
          isRetweeted = true;
          totalRetweets = totalRetweets+1;
        });
      }
    }

    Color calculateRetweetButtonColor() {
      return isRetweeted ? Pallete.greenColor : Pallete.greyColor;
    }





    if (userProfilePic != '') {
      backgroundImageProvider = NetworkImage(userProfilePic);
    } else {
      backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);
    }

    void navigateToTweetDetails(){
      Navigator.pushNamed(context, TweetDetails.routeName, arguments: widget.tweets);
    }


    return GestureDetector(
      onTap: (){
        navigateToTweetDetails();
        tweetedByUsername = widget.tweets.tweeted_by_username;
      },
      child: Container(
        width: 270,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Pallete.bottomBorderColor,
                    width: 1
                )
            )
          // color: Colors.white12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              if(widget.tweets.hasUserRetweeted==1 && widget.hideRetweetedText==false)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 40),
                      SvgPicture.asset(AssetsConstants.retweetIcon,color: Pallete.postHintColor,height: 16,),
                      SizedBox(width: 10),
                      Text('You reposted',
                        style: TextStyle(
                            color: Pallete.postHintColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: backgroundImageProvider,
                    radius: 22,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 270,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.tweets.tweeted_by_name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                ),
                                SizedBox(width: 3),
                                if(widget.tweets.is_tweeted_by_blue==1)
                                  Container(
                                      width: 18,
                                      height: 18,
                                      child: SvgPicture.asset(AssetsConstants.verifiedIcon)),
                                SizedBox(width: 3),
                                Text('@${widget.tweets.tweeted_by_username} • ${timeago.format(widget.tweets.tweeted_at,locale: 'en_short')}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Pallete.greyColor,
                                      fontSize: 14
                                  ),)
                              ],
                            ),
                            Icon(
                              Icons.more_vert_outlined,
                              color: Pallete.greyColor,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                          width: 270,
                          child: HashTagText(text: widget.tweets.content,textColor: Pallete.whiteColor,)
                      ),
                      if(widget.tweets.imageUrls!= [])
                        Container(
                          width: 270,
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: widget.tweets.imageUrls!.asMap().entries.map((entry) {
                              final index = entry.key;
                              final imageFiles = entry.value;
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(imageFiles.toString()),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      SizedBox(height: 5),
                      Container(
                        width: 270,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TweetIconButton(
                                pathName: AssetsConstants.commentIcon,
                                text: totalComments.toString(),
                                onTap: (){
                                  openReplyScreen(context);
                                }),
                            TweetIconButton(
                              pathName: AssetsConstants.retweetIcon,
                              color: calculateRetweetButtonColor(),
                              text: totalRetweets.toString(),
                              onTap: () {
                                setState(() {
                                  textDemo = 'yoo';
                                });
                                retweetATweet();
                                changeRetweetStatus(); // Update the retweet status
                              },
                            ),


                            LikeButton(

                              onTap: tweetServices.exampleFunction,


                              size: 18,
                              isLiked: isLiked,
                              likeBuilder: (isLiked) {
                                return isLiked
                                    ? SvgPicture.asset(
                                    AssetsConstants.likeFilledIcon,
                                    color: Pallete.redColor)
                                    : SvgPicture.asset(
                                    AssetsConstants.likeOutlinedIcon,
                                    color: Pallete.greyColor);
                              },
                              likeCount: totalLikes,
                              countBuilder: (likeCount, isLiked, text){
                                return Text(
                                  text,
                                  style: TextStyle(
                                      color: isLiked ? Pallete.redColor : Pallete.greyColor,
                                      fontSize: 13
                                  ),
                                );
                              },

                            ),

                            TweetIconButton(
                                pathName: AssetsConstants.viewsIcon,
                                text: totalViews.toString(),
                                onTap: (){}),
                            TweetIconButton(
                                pathName: AssetsConstants.shareIcon,
                                onTap: (){
                                  likeATweet();
                                }),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
