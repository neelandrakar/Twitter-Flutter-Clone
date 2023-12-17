import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/features/messeges/widgets/chat_room_card.dart';
import 'package:twitter_clone/providers/chat_room_provider.dart';

import '../../../models/chat_room.dart';
import '../../../theme/pallete.dart';
import '../services/messages_services.dart';

class ChatList extends StatefulWidget {
  // static const String routeName = '/add-new-chat-screen';
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  final MessagesService messagesService = MessagesService();
  List<ChatRoom> fetchedChatRooms = [];


  void fetchAllChatRooms() async{
    fetchedChatRooms = await messagesService.fetchChatRooms(context: context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAllChatRooms();
    });

    // listenToMessages();
  }

  @override
  Widget build(BuildContext context) {

    var chatRoomProvider = Provider.of<ChatRoomProvider>(context, listen: false);
    print('chatroomlength: ${chatRoomProvider.chatrooms.length}');

    return Center(
      child:  chatRoomProvider.chatrooms.length>0 ? ListView.builder(
          itemCount: chatRoomProvider.chatrooms.length,
          itemBuilder: (context,index){
            return ChatRoomCard(chatModel: chatRoomProvider.chatrooms[index]);
          }) : SpinKitRing(color: Pallete.blueColor,lineWidth: 4,size: 40,),
    );
  }
}
