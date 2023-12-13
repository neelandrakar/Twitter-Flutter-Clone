import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/constants/utils.dart';
import 'package:twitter_clone/features/messeges/services/messages_services.dart';
import 'package:twitter_clone/providers/message_provider.dart';
import 'package:twitter_clone/theme/pallete.dart';
import '../../../models/message.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/ui_constants/assets_constants.dart';

class ChatScreen extends StatefulWidget {

  static const String routeName = '/chat-screen';
  final User receiver;
  const ChatScreen({super.key, required this.receiver});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  String chatRoomId = '';
  final MessagesService messagesService = MessagesService();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchChatRoomId();
    });

    // listenToMessages();
  }

  fetchChatRoomId() async {

    chatRoomId = await messagesService.fetchChatRoomId(context: context, receiverUserId: widget.receiver.id);
    connectToRoom(chatRoomId);

  }

  void connectToRoom(String roomName) {
    socket = IO.io(uri, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();

    socket.onConnect((data) {
      if (mounted) {
        socket.emit('/join_room', roomName);
        print('user has joined $roomName');
      } else{
        print('error while connecting');
      }
    });

    socket.onDisconnect((data) {
      print('Disconnected from the server');
    });

    listenToMessages();
  }

  void sendMessage() {
    String text = messageController.text;
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (mounted) {
      socket.emit('/send_message', {
        'text': text,
        'sender': user.name,
        'receiver': widget.receiver.name
      });
    }
  }

  void listenToMessages() {
    socket.on('message', (data) {
      if (mounted) {
        print('Received message: $data');
        // Handle the received message as needed
        showSnackBar(context, data['text']);
        // Provider.of<MessageProvider>(context, listen: false).addNewMessage(
        //     Message.fromJson(data));

      }
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context, listen: false).user;

    String name = user.name;
    String userId = user.id;
    String userProfilePic = widget.receiver.profilePicture!;
    ImageProvider<Object> backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);

    if (userProfilePic != '') {
      backgroundImageProvider = NetworkImage(userProfilePic);
    } else {
      backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);
    }




    return Scaffold(
      backgroundColor: myColors.mainBackgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: backgroundImageProvider,
              radius: 15,
            ),
            SizedBox(width: 10,),
            Text(
              widget.receiver.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Pallete.whiteColorSecond,
                  fontSize: 17
              ),
            ),
            SizedBox(width: 5,),
            if(widget.receiver.hasBlue==1)
              SvgPicture.asset(
                AssetsConstants.verifiedIcon,
                width: 14,
                height: 14,
              )
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.info_outline,
              color: Pallete.whiteColorSecond,
              size: 22,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MessageProvider>(
              builder: (_, provider, __) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {


                  final message = provider.messages[index];
                  bool isMe = message.sender == user.id ? true : false;


                  return Align(
                    alignment: isMe
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                          decoration: BoxDecoration(
                              color: isMe
                                  ? Pallete.blueColor
                                  : Pallete.receiverTextColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: isMe ? Radius.circular(20) : Radius.circular(3),
                                bottomRight: isMe ? Radius.circular(3) : Radius.circular(20),
                              )),
                          child:
                          Text(
                            message.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15
                            ),
                          ),
                          // Text(
                          //   DateFormat('hh:mm a').format(message.sentAt),
                          //   style: Theme.of(context).textTheme.bodySmall,
                          // ),

                        ),
                        Text('data', style: TextStyle(color: Colors.red),)

                      ],
                    ),
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: provider.messages.length,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (messageController.text.trim().isNotEmpty) {
                        sendMessage();
                        messageController.clear();
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}