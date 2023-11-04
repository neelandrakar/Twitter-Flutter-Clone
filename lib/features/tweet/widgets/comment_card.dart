import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_icon_button.dart';
import 'package:twitter_clone/models/comments.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../widgets/ui_constants/assets_constants.dart';
import 'hashtag_text.dart';

class CommentCard extends StatefulWidget {
  final Comments comments;
  const CommentCard({super.key, required this.comments});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {

  ImageProvider<Object> backgroundImageProvider = AssetImage(AssetsConstants.searchIcon);



  @override
  Widget build(BuildContext context) {

    String userProfilePic = widget.comments.commented_by_avi;
    int totalComments = 2;
    int totalRetweets = widget.comments.retweeted_by!.length;
    int totalLikes = widget.comments.liked_by!.length;
    int totalViews = totalComments + totalRetweets + totalLikes;

    if (userProfilePic != '') {
      backgroundImageProvider = NetworkImage(userProfilePic);
    } else {
      backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);
    }


    return Container(
      width: 270,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Pallete.bottomBorderColor,
            width: 1
          )
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0).copyWith(right: 0),
        child: Row(
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
                            widget.comments.commented_by_name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                          SizedBox(width: 3),
                          if(1==1)
                            Container(
                                width: 18,
                                height: 18,
                                child: SvgPicture.asset(AssetsConstants.verifiedIcon)),
                          SizedBox(width: 3),
                          Text('@${'johnoe'} • ${timeago.format(widget.comments.commented_at,locale: 'en_short')}',
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
                    child: HashTagText(text: widget.comments.content)
                ),
                if(widget.comments.imageUrls!= [])
                  Container(
                    width: 270,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: widget.comments.imageUrls!.asMap().entries.map((entry) {
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
                          }),
                      TweetIconButton(
                        pathName: AssetsConstants.retweetIcon,
                        color: Pallete.greyColor,
                        text: totalRetweets.toString(),
                        onTap: () {
                        },
                      ),


                      LikeButton(

                        size: 18,
                        isLiked: true,
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
                            // likeATweet();
                          }),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
