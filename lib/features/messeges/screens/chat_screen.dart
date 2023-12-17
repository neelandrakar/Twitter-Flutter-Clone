import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/messeges/services/messages_services.dart';
import 'package:twitter_clone/models/chat_room.dart';
import 'package:twitter_clone/providers/message_provider.dart';
import 'package:twitter_clone/theme/pallete.dart';
import '../../../models/message.dart';
import '../../../providers/chat_room_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/ui_constants/assets_constants.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat-screen';
  final String chatRoomId;
  final String receiversName;
  final String receiversUsername;
  final String receiversProfilePic;
  final String receiversId;
  final int receiversBlueStatus;
  final ChatRoom chatRoom;
  const ChatScreen(
      {super.key,
      required this.chatRoomId,
      required this.receiversName,
      required this.receiversUsername,
      required this.receiversProfilePic,
      required this.receiversBlueStatus,
      required this.receiversId,
      required this.chatRoom});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final MessagesService messagesService = MessagesService();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connectToRoom(widget.chatRoomId);
    });

    // listenToMessages();
  }

  // fetchChatRoomId() async {
  //
  //   chatRoomId = await messagesService.fetchChatRoomId(context: context, receiverUserId: widget.receiver.id);
  //   connectToRoom(chatRoomId);
  //
  // }

  void sendMessageToDatabase() {
    messagesService.sendMessage(
        context: context,
        text: messageController.text,
        chatRoomId: widget.chatRoomId,
        receiverId: widget.chatRoomId);

    print('message sent');
  }

  void connectToRoom(String roomName) {
    print('roomname $roomName');
    socket = IO.io(uri, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();

    socket.onConnect((data) {
      if (mounted) {
        socket.emit('/join_room', roomName);
        print('user has joined $roomName');
      } else {
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
      socket.emit('/send_message',
          {'text': text, 'sender': user.id, 'receiver': widget.receiversId});
    }

    sendMessageToDatabase();
  }

  void listenToMessages() {
    socket.on('message', (data) {
      print('message found');
      if (mounted) {
        print('aish: ' + jsonEncode(data));
        Message newMessage = Message.fromMap(jsonDecode(jsonEncode(data)));
        print('newMessage: $newMessage');
        // print('Received mssage: $data');
        // Handle the received message as needed
        // showSnackBar(context, data['text']);
        // print(data);
        Provider.of<ChatRoomProvider>(context, listen: false)
            .addNewMessage(newMessage, widget.chatRoomId);
        setState(() {});
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
    String userProfilePic = widget.receiversProfilePic;
    ImageProvider<Object> backgroundImageProvider =
        AssetImage(AssetsConstants.noProfilePic);

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
            SizedBox(
              width: 10,
            ),
            Text(
              widget.receiversName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Pallete.whiteColorSecond,
                  fontSize: 17),
            ),
            SizedBox(
              width: 5,
            ),
            if (widget.receiversBlueStatus == 1)
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
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                var message = widget.chatRoom.messages[index];
                var messages = widget.chatRoom.messages;
                var sender = message.sender;
                print(
                    'userid: ${user.id}\nsenderId: ${sender}\nreceiver: ${widget.receiversName}');
                bool isMe = sender == user.id ? true : false;


                List<Message> senderMsgs = [];
                List<Message> receiverMsgs = [];

                for(int i=0; i < messages.length; i++) {
                  if (messages[i].sender == user.id) {
                    senderMsgs.add(messages[i]);
                  } else {
                    receiverMsgs.add(messages[i]);
                  }
                }

                print('length of sendermsg: ${senderMsgs.length}');
                print('length of receivesMsgs: ${receiverMsgs.length}');

                bool lastIndex = index == messages.length - 1;
                bool timeGap = index > 0 &&
                    messages[index]
                            .sent_on
                            .difference(messages[index - 1].sent_on)
                            .inMinutes >= 1;

                bool timeGapSender = index != messages.length - 1 &&
                    messages[index + 1]
                                    .sent_on
                                    .difference(messages[index].sent_on)
                                    .inMinutes >= 1;

                // bool timeGapReceiver = index != messages.length - 1 &&
                //     receiverMsgs[index + 1]
                //         .sent_on
                //         .difference(receiverMsgs[index].sent_on)
                //         .inMinutes >= 1;

                // if(index!=provider.messages.length-1) {
                //   print('diff ' + provider.messages[index + 1].sent_on
                //       .difference(message.sent_on)
                //       .inMinutes
                //       .toString());
                // }

                return Align(
                  alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: isMe ? CrossAxisAlignment.end
                                             : CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: timeGap ? 25 : 3),
                      InkWell(
                        onTap: () {
                          print(message.text);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          decoration: BoxDecoration(
                              color: isMe
                                  ? Pallete.blueColor
                                  : Pallete.receiverTextColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: isMe
                                    ? Radius.circular(20)
                                    : Radius.circular(3),
                                bottomRight: isMe
                                    ? Radius.circular(3)
                                    : Radius.circular(20),
                              )),
                          child: Text(
                            message.text,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          // Text(
                          //   DateFormat('hh:mm a').format(message.sentAt),
                          //   style: Theme.of(context).textTheme.bodySmall,
                          // ),
                        ),
                      ),
                      SizedBox(height: 2),
                      if (lastIndex || timeGapSender)
                        Text(
                          DateFormat('h:mm a').format(message.sent_on),
                          style: TextStyle(
                              color: Pallete.textTimeColor, fontSize: 11),
                        )

                    ],
                  ),
                );
              },
              itemCount: widget.chatRoom.messages.length,
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
