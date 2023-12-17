import 'package:flutter/cupertino.dart';
import 'package:twitter_clone/models/chat_room.dart';
import 'package:twitter_clone/models/message.dart';

class ChatRoomProvider extends ChangeNotifier{

  List<ChatRoom> chatrooms = [];


  void addChatRoom(ChatRoom chatRoom){
    chatrooms.add(chatRoom);
    notifyListeners();
  }

  void addNewMessage(Message msg, String chatRoomId){
    for(int i=0; i< chatrooms.length; i++){
      if(chatRoomId == chatrooms[i].id){
        print('found');
        chatrooms[i].messages.add(msg);
        notifyListeners();
        print('done adding');
        break;
      } else{
        print('no match');
      }
    }
  }

  void removeChatRoom(ChatRoom chatRoom){
    chatrooms.remove(chatRoom);
    notifyListeners();
  }

}