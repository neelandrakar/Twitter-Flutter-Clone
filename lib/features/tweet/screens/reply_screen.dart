import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/tweet/services/tweet_services.dart';
import 'package:twitter_clone/features/tweet/widgets/hashtag_text.dart';
import 'package:twitter_clone/models/tweets.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/ui_constants/assets_constants.dart';
import '../../../widgets/ui_constants/create_tweet_app_bar.dart';

class ReplyScreen extends StatefulWidget {
  final Tweets tweet;
  const ReplyScreen({super.key, required this.tweet});

  @override
  State<ReplyScreen> createState() => _ReplyScreenState();
}

class _ReplyScreenState extends State<ReplyScreen> {

  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    String tweetersProfilePic = widget.tweet.tweeted_by_avi;
    String? usersProfilePic = userProvider.user.profilePicture;
    final TextEditingController _commentTextController =
        TextEditingController();
    final TweetServices tweetServices = TweetServices();

    List<File> videos = [];

    void selectImages() async {
      var res = await pickImages();

      setState(() {
        images = res;
      });
      print("final list $images");
    }

    void postMyReply() {
      tweetServices.replyToATweet(
          context: context,
          onSuccess: () {
            Navigator.pop(context);
          },
          content: _commentTextController.text,
          id: widget.tweet.id,
          imageFile: images,
          videoFile: videos);

      print(images);
    }

    ImageProvider<Object> backgroundImageProviderForTweeter;
    if (tweetersProfilePic != '') {
      backgroundImageProviderForTweeter = NetworkImage(tweetersProfilePic);
    } else {
      backgroundImageProviderForTweeter =
          AssetImage(AssetsConstants.noProfilePic);
    }

    ImageProvider<Object> backgroundImageProviderForUser;
    if (usersProfilePic != '') {
      backgroundImageProviderForUser = NetworkImage(usersProfilePic!);
    } else {
      backgroundImageProviderForUser = AssetImage(AssetsConstants.noProfilePic);
    }

    int crossAxisCount = 0;
    if (widget.tweet.imageUrls!.length == 1) {
      crossAxisCount = 1;
    } else if (widget.tweet.imageUrls!.length == 2) {
      crossAxisCount = 2;
    }

    return Scaffold(
      backgroundColor: myColors.mainBackgroundColor,
      appBar: CreateTweetAppBar(
        postTweet: () {
          postMyReply();
        },
        tweetLength: _commentTextController.text,
        postButtonName: 'Reply',
        showDrafts: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: backgroundImageProviderForTweeter,
                            radius: 18,
                            backgroundColor: Colors.transparent,
                          ),
                          Container(
                            width: 2,
                            height: 10,
                            color: Pallete.postHintColor,
                          ),
                          // SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        fontSize: 15),
                                  ),
                                  if (widget.tweet.is_tweeted_by_blue == 1)
                                    SizedBox(
                                      width: 3,
                                    ),
                                  if (widget.tweet.is_tweeted_by_blue == 1)
                                    Container(
                                      height: 15,
                                      width: 15,
                                      child: SvgPicture.asset(
                                          AssetsConstants.verifiedIcon),
                                    ),
                                  SizedBox(width: 3),
                                  Text(
                                    '@${widget.tweet.tweeted_by_username}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Pallete.greyColor, fontSize: 15),
                                  )
                                ],
                              ),
                              Text(
                                '${timeago.format(widget.tweet.tweeted_at, locale: 'en_short')}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Pallete.greyColor, fontSize: 14),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 200,
                                  child:
                                      HashTagText(text: widget.tweet.content)),
                              if (widget.tweet.imageUrls!.length > 0)
                                Container(
                                  width: 80,
                                  // height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10.0)), // Set the radius value
                                  ),
                                  child: GridView.count(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 1,
                                    shrinkWrap: true,
                                    children: widget.tweet.imageUrls!
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      final index = entry.key;
                                      final imageFiles = entry.value;
                                      return Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      imageFiles.toString()),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: backgroundImageProviderForUser,
                  radius: 18,
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: _commentTextController,
                    maxLines: null,
                    autofocus: true,
                    cursorColor: Pallete.blueColor,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Set the text color here
                    ),
                    decoration: InputDecoration(
                      hintText: "Post your reply",
                      hintStyle: TextStyle(
                        color: Pallete.postHintColor,
                        // fontWeight: FontWeight.w600
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Pallete.bottomBorderColor))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: InkWell(
                  onTap: () {
                    selectImages();
                  },
                  child: SvgPicture.asset(AssetsConstants.galleryIcon)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: SvgPicture.asset(AssetsConstants.gifIcon),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: Icon(
                Icons.poll_outlined,
                color: Pallete.blueColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: Icon(
                Icons.location_on_outlined,
                color: Pallete.blueColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
