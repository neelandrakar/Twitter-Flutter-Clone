import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_button.dart';
import 'package:twitter_clone/widgets/custom_widgets/rounded_small_button.dart';
import 'package:twitter_clone/widgets/ui_constants/assets_constants.dart';

class CreateTweetAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback postTweet;
  final String tweetLength;
  const CreateTweetAppBar({super.key, required this.postTweet, required this.tweetLength});

  @override
  State<CreateTweetAppBar> createState() => _CreateTweetAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CreateTweetAppBarState extends State<CreateTweetAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close,
          color: myColors.whiteColor,),

        ),
      actions: [
        Center(child: Text('Drafts',style: TextStyle(fontWeight: FontWeight.bold,color: Pallete.blueColor,fontSize: 16),)),
        RoundedSmallButton(
          onTap: (){
            print(widget.tweetLength.length > 1);
              widget.postTweet.call();
          },
          label: 'Post',
          backgroundColor: Pallete.blueColor,
          textColor: myColors.whiteColor,)
      ],

    );
  }
}
