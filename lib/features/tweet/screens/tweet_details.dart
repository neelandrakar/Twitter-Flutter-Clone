import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/tweet/services/tweet_services.dart';
import 'package:twitter_clone/features/tweet/widgets/comment_card.dart';
import 'package:twitter_clone/features/tweet/widgets/hashtag_text.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../../models/comments.dart';
import '../../../models/tweets.dart';
import '../../../widgets/ui_constants/assets_constants.dart';
import '../widgets/tweet_icon_button.dart';

class TweetDetails extends StatefulWidget {
  final Tweets tweet;
  static const String routeName = '/tweet-details';
  const TweetDetails({super.key, required this.tweet});

  @override
  State<TweetDetails> createState() => _TweetDetailsState();
}

class _TweetDetailsState extends State<TweetDetails> {

  ImageProvider<Object> backgroundImageProvider = AssetImage(AssetsConstants.searchIcon);

  List<Comments>? allFetchedComments = [];
  bool isLiked = false;

  final TweetServices tweetServices = TweetServices();

  void fetchAllComments () async {

    allFetchedComments = await tweetServices.fetchAllComments(context: context, id: widget.tweet.id);
    setState(() {});
    print(allFetchedComments!.length.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAllComments();
    });

    //print(allFetchedTweets.toString());
  }


  @override
  Widget build(BuildContext context) {

    String userProfilePic = widget.tweet.tweeted_by_avi;
    if (userProfilePic != '') {
      backgroundImageProvider = NetworkImage(userProfilePic);
    } else {
      backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);
    }

    List<String> imageUrls = widget.tweet.imageUrls!;

    String formatDateTime(DateTime inputDateTime) {

      //final dateTime = DateTime.parse(inputDateTime);
      final formattedDate = DateFormat("hh:mm a • dd MMM yy").format(inputDateTime);

      return formattedDate;
    }

    int totalComments = widget.tweet.comments!.length;
    int totalRetweets = widget.tweet.retweeted_by!.length;
    int totalLikes = widget.tweet.liked_by!.length;
    int totalViews = totalComments + totalRetweets + totalLikes;

    Color retweetColor = Pallete.greyColor;



    return Scaffold(
      appBar: AppBar(

        title: Text(
          'Post'
        ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: Pallete.bottomBorderColor,
              height: 1.0,
            ),
          )

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: backgroundImageProvider,
                        radius: 22,
                      ),

                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.tweet.tweeted_by_name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 14
                            ),
                          ),
                          SizedBox(width: 5,),
                          if(widget.tweet.is_tweeted_by_blue==1)
                            Container(
                                width: 15,
                                height: 15,
                                child: SvgPicture.asset(AssetsConstants.verifiedIcon)),

                        ],
                      ),
                      Text(
                        '@${widget.tweet.tweeted_by_username}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: Pallete.greyColor,
                            fontSize: 13
                        ),
                      ),
                    ],
                  ),

                    ],
                  ),
                  Icon(
                    Icons.more_vert_outlined,
                    color: Pallete.greyColor,
                    size: 15,
                  )
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: HashTagText(text: widget.tweet.content)),

              SizedBox(height: 10),
              if(widget.tweet.imageUrls!= [])
                Container(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: imageUrls.length>1 ? 2 : 1,

                    childAspectRatio: 1,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: widget.tweet.imageUrls!.asMap().entries.map((entry) {
                      final index = entry.key;
                      final imageFiles = entry.value;
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(imageFiles.toString()),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: imageUrls.length>1
                                  ? BorderRadius.only(
                                   bottomLeft: Radius.circular(10),
                                   topLeft: Radius.circular(10),
                                   bottomRight: Radius.circular(10),
                                   topRight: Radius.circular(10),
                                )
                                  : BorderRadius.all(Radius.circular(10))
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.topLeft,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${formatDateTime(widget.tweet.tweeted_at)} • ',
                        style: TextStyle(
                          color: Pallete.greyColor
                        )
                      ),
                      TextSpan(
                        text: totalViews.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: myColors.whiteColor),

                      ),
                      TextSpan(
                        text: totalViews>1 ? ' Views' : ' View',
                          style: TextStyle(
                              color: Pallete.greyColor
                          )
                      ),
                    ],
                  ),
                )
              ),
              SizedBox(height: 15,),
              Divider(
               height: 1,
               color: Pallete.bottomBorderColor,
                thickness: 1,
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Text(totalRetweets.toString(),
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(width: 5),
                  Text(totalComments>1 ? 'Comments' : 'Comment' ,
                    style: TextStyle(
                        color: Pallete.greyColor
                    ),),
                  SizedBox(width: 10),
                  Text(totalRetweets.toString(),
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(width: 5),
                  Text(totalRetweets>1 ? 'Reposts' : 'Repost' ,
                    style: TextStyle(
                        color: Pallete.greyColor
                    ),),
                  SizedBox(width: 10,),
                  Text(totalLikes.toString(),
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(width: 5),
                  Text(totalLikes>1 ? 'Likes' : 'Like' ,
                    style: TextStyle(
                        color: Pallete.greyColor
                    ),),
                ],
              ),
              SizedBox(height: 15,),
              Divider(
                height: 1,
                color: Pallete.bottomBorderColor,
                thickness: 1,
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TweetIconButton(
                        pathName: AssetsConstants.commentIcon,
                        text: totalComments.toString(),
                        onTap: (){
                        }),
                    TweetIconButton(
                      pathName: AssetsConstants.retweetIcon,
                      color: retweetColor,
                      text: totalRetweets.toString(),
                      onTap: () {
                        setState(() {
                          retweetColor = Colors.pink;
                        });
                      },
                    ),


                    LikeButton(

                      // onTap: tweetServices.exampleFunction,


                      size: 18,
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
                        }),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Divider(
                height: 1,
                color: Pallete.bottomBorderColor,
                thickness: 1,
              ),
              SizedBox(height: 10,),
              ListView.builder(
                  itemCount: allFetchedComments!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CommentCard(comments: allFetchedComments![index]);
                    // return Text('hello', style: TextStyle(color: Colors.white));
                  },
                ),

            ],
          ),
        ),
      )
    );
  }
}
