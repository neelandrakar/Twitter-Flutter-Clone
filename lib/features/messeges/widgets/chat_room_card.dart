import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/features/messeges/screens/chat_screen.dart';

import '../../../models/chat_room.dart';
import '../../../theme/pallete.dart';
import '../../../widgets/ui_constants/assets_constants.dart';
import '../services/messages_services.dart';

class ChatRoomCard extends StatefulWidget {
  final ChatRoom chatModel;
  const ChatRoomCard({super.key, required this.chatModel});

  @override
  State<ChatRoomCard> createState() => _ChatRoomCardState();
}

class _ChatRoomCardState extends State<ChatRoomCard> {


  void navigateToAddNewChatScreen(){
    
    print('chatroom ${widget.chatModel.id}');

    Navigator.pushNamed(
        context,
        ChatScreen.routeName,
        arguments: ChatScreen(
            chatRoomId: widget.chatModel.id,
            receiversName: widget.chatModel.receiversName,
            receiversUsername: widget.chatModel.receiversUsername,
            receiversProfilePic: widget.chatModel.receiversProfilePic,
            receiversBlueStatus: widget.chatModel.receiversBlueStatus,
            receiversId: widget.chatModel.receiversId,
            chatRoom: widget.chatModel,
        )
    );

    print('navigated');
  }


  @override
  Widget build(BuildContext context) {

    String userProfilePic = widget.chatModel.receiversProfilePic;
    ImageProvider<Object> backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);
    if (userProfilePic != '') {
      backgroundImageProvider = NetworkImage(userProfilePic);
    } else {
      backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);
    }

    var messages = widget.chatModel.messages;


    return InkWell(
        onTap: (){

          navigateToAddNewChatScreen();

        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 13),
          child: Row(
            children: [

              CircleAvatar(
                backgroundImage: backgroundImageProvider,
                radius: 24,
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.chatModel.receiversName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Pallete.whiteColorSecond,
                            fontSize: 16
                        ),
                      ),
                      SizedBox(width: 3),
                      if(widget.chatModel.receiversBlueStatus==1)
                        Container(
                            width: 13,
                            height: 13,
                            child: SvgPicture.asset(AssetsConstants.verifiedIcon)),
                      SizedBox(width: 3,),
                      Text(
                        '@${widget.chatModel.receiversUsername}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: Pallete.postHintColor,
                            fontSize: 14
                        ),
                      ),
                      SizedBox(width: 3),
                      Text('•',style: TextStyle(color: Pallete.postHintColor),),
                      SizedBox(width: 3),
                      Text('1d',style: TextStyle(color: Pallete.postHintColor),)
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(messages[messages.length-1].text,style: TextStyle(color: Pallete.postHintColor,fontSize: 15),)
                  //Last text
                ],
              ),
            ],
          ),
        ),
      );
  }
}
