import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/profile/services/profile_services.dart';
import 'package:twitter_clone/features/profile/widgets/liked_tweets.dart';
import 'package:twitter_clone/features/profile/widgets/media_tweets.dart';
import 'package:twitter_clone/features/profile/widgets/my_posts.dart';
import 'package:twitter_clone/features/profile/widgets/profile_tabs.dart';
import 'package:twitter_clone/features/tweet/widgets/hashtag_text.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_button.dart';
import 'package:twitter_clone/widgets/ui_constants/assets_constants.dart';

import '../../../models/tweets.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile-screen';
  // final User user;
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {


    ImageProvider<Object> profileImageProvider = AssetImage(AssetsConstants.searchIcon);
    ImageProvider<Object> coverImageProvider = AssetImage(AssetsConstants.searchIcon);

    // final user = widget.user;
    final user = Provider.of<UserProvider>(context, listen: false).user;


    String userProfilePic = user.profilePicture!;
    String userCoverPic = user.coverPicture!;

    if (userProfilePic != '') {
      profileImageProvider = NetworkImage(userProfilePic);
    } else {
      profileImageProvider = AssetImage(AssetsConstants.noProfilePic);
    }

    if (userCoverPic != '') {
      coverImageProvider = NetworkImage(userProfilePic);
    } else {
      coverImageProvider = AssetImage(AssetsConstants.noProfilePic);
    }

    void debugPrint(String msg){
      print(msg);
    }

    int countOfFollowing = user.user_followed!.length;
    int countOfFollowers = user.followed_by!.length;


    String joinedDate = DateFormat('MMMM y').format(user.created_at!);


    return SafeArea(
        child: NestedScrollView(

          headerSliverBuilder: (context, innerBoxIsSelected){
            return [
              SliverAppBar(
                expandedHeight: 360,
                backgroundColor: myColors.mainBackgroundColor,
                floating: true,
                pinned: true,
                title: Text(user.name),
                excludeHeaderSemantics: true,
                forceMaterialTransparency: false,
                flexibleSpace:
                FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  // title: Text(user.name),

                  background: Column(
                    children: [
                      userCoverPic!='' ? Container(
                        height: 130,
                        width: double.infinity,
                        child: Image.network(userCoverPic,fit: BoxFit.cover,),
                      ) :
                      Container(height: 130,color: Pallete.blueColor,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        transform: Matrix4.translationValues(0.0, -30.0,0),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(

                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 3),
                                        shape: BoxShape.circle
                                    ),
                                    alignment: Alignment.topLeft,
                                    child:
                                    CircleAvatar(
                                      foregroundImage: profileImageProvider,
                                      radius: 30,
                                    )
                                ),
                                CustomButton(
                                    onClick: (){},
                                    buttonText: 'Edit Profile',
                                    borderRadius: 20,
                                    width: 50,height: 30,
                                    textColor: Pallete.whiteColor,
                                    buttonColor: myColors.mainBackgroundColor,
                                    borderColor: Pallete.bottomBorderColor
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              user.name,
                              style: TextStyle(
                                  color: Pallete.whiteColorSecond,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '@${user.username}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Pallete.postHintColor,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 12),
                            HashTagText(
                              text: user.bio!,
                              textColor: Pallete.whiteColorSecond,),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.calendar_month_outlined,color: Pallete.postHintColor,size: 15,),
                                SizedBox(width: 5),
                                Text('Joined $joinedDate',
                                  style: TextStyle(
                                      color: Pallete.postHintColor,
                                      fontSize: 16
                                  ),)
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Text(countOfFollowing.toString(),
                                  style: TextStyle(
                                      color: Pallete.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(width: 3),
                                Text('Following',
                                  style: TextStyle(
                                      color: Pallete.postHintColor,
                                      fontSize: 16
                                  ),),
                                SizedBox(width: 10),
                                Text(countOfFollowers.toString(),
                                  style: TextStyle(
                                      color: Pallete.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(width: 3),
                                Text('Followers',
                                  style: TextStyle(
                                      color: Pallete.postHintColor,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: DefaultTabController(
            length: 5,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: AppBar(
                    automaticallyImplyLeading: false,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(35),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Pallete.bottomBorderColor,width: 1)
                          )
                        ),
                        child: TabBar(

                            unselectedLabelColor: Pallete.postHintColor,
                            indicatorColor: Pallete.blueColor,
                            labelColor: Pallete.whiteColorSecond,
                            // labelStyle: TextStyle(
                            //   fontSize: 20
                            // ),
                            isScrollable: true,
                            tabs: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('Posts',
                                  style: TextStyle(
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('Replies',
                                  style: TextStyle(
                                      fontSize: 16
                                  ),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('Highlights',
                                  style: TextStyle(
                                      fontSize: 16
                                  ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text('Media',
                                  style: TextStyle(
                                      fontSize: 16
                                  ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text('Likes',
                                  style: TextStyle(
                                      fontSize: 16
                                  ),),
                              ),
                            ]
                        ),
                      ),
                    )
                ),
              ),

              body: Column(
                children: [
                  SizedBox(height: 5),
                  Expanded(
                    child: TabBarView(
                      children: [
                        MyPosts(user: user),
                        Text('Replies Screen',style: TextStyle(color: Pallete.whiteColor),),
                        Text('Highlights Screen',style: TextStyle(color: Pallete.whiteColor),),
                        MediaTweets(user: user),
                        LikedTweets(user: user),

                      ],
                    ),
                  ),
                ],
              ),

            ),
          ),
        )
    );
  }
}
