import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/features/messeges/screens/chat_screen.dart';

import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import '../../../theme/pallete.dart';
import '../../../widgets/ui_constants/assets_constants.dart';

class TextNewUserCard extends StatefulWidget {
  final User user;
  const TextNewUserCard({super.key, required this.user});

  @override
  State<TextNewUserCard> createState() => _TextNewUserCardState();
}

class _TextNewUserCardState extends State<TextNewUserCard> {
  @override
  Widget build(BuildContext context) {

    String userProfilePic = widget.user.profilePicture!;
    ImageProvider<Object> backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);

    if (userProfilePic != '') {
      backgroundImageProvider = NetworkImage(userProfilePic);
    } else {
      backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);
    }

    void navigateToChatScreen(){
      Navigator.pushNamed(context, ChatScreen.routeName, arguments: widget.user);
    }



    return InkWell(
      onTap: (){
        print(widget.user.name);
        navigateToChatScreen();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 13),
        child: Row(
          children: [

            CircleAvatar(
              backgroundImage: backgroundImageProvider,
              radius: 17,
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.user.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Pallete.whiteColorSecond,
                          fontSize: 16
                      ),
                    ),
                    SizedBox(width: 3),
                    if(widget.user.hasBlue==1)
                      Container(
                          width: 13,
                          height: 13,
                          child: SvgPicture.asset(AssetsConstants.verifiedIcon)),
                  ],
                ),
                SizedBox(height: 3),
                Text(
                  '@${widget.user.username}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Pallete.postHintColor,
                      fontSize: 14
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
