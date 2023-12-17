import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_clone/constants/http_error_handle.dart';
import 'package:twitter_clone/constants/utils.dart';
import 'package:twitter_clone/models/chat_room.dart';
import 'package:twitter_clone/models/message.dart';
import 'package:twitter_clone/providers/chat_room_provider.dart';
import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class MessagesService{

  Future<String> fetchChatRoomId({
    required BuildContext context,
    required String receiverUserId
  }) async{

    String chatRoomId = '';
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try{

      Map data = {
        'receiverUserId': receiverUserId,
      };

      String jsonBody = jsonEncode(data);

      http.Response res = await http.post(
          Uri.parse('$uri/api/check-chat-room-status'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonBody
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: (){
            print(jsonDecode(res.body));

            chatRoomId = jsonDecode(res.body);
            print('chatroom: ' + chatRoomId);
          }
      );



    }catch(e){

      print(e.toString());
    }


    return chatRoomId;
}

  Future<bool> fetchUserChatStatus({
    required BuildContext context,
  }) async{

    bool userHasChatted = false;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try{




      http.Response res = await http.get(
          Uri.parse('$uri/api/check-user-chat-status'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: (){
            print(jsonDecode(res.body));

            userHasChatted = jsonDecode(res.body);
          }
      );



    }catch(e){

      print(e.toString());
    }


    return userHasChatted;
  }

  Future<List<User>> fetchChatSuggestions({
    required BuildContext context,
  }) async {
    List<User> chatSuggestions = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/fetch-chat-suggestions'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Parse and map the JSON data to User objects
          List<dynamic> jsonData = json.decode(res.body);
          List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(jsonData);
          chatSuggestions = jsonList.map((map) => User.fromMap(map)).toList();
        },
      );
    } catch (e) {
      print(e.toString());
    }

    return chatSuggestions;
  }

  Future<List<ChatRoom>> fetchChatRooms({
    required BuildContext context,
  }) async {
    List<ChatRoom> chatRooms = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/fetch-chat-rooms'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Parse and map the JSON data to User objects
          print('fetching chat rooms... ');
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            chatRooms
                .add(ChatRoom.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            print('lenght of chatrooms ${chatRooms.length}');
            Provider.of<ChatRoomProvider>(context, listen: false).addChatRoom(ChatRoom.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            showSnackBar(context, 'chatroom added to provider');


          }

          print(res.body);
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }

    return chatRooms;
  }


  //Send a mesage
  void sendMessage({
    required BuildContext context,
    required String text,
    required String chatRoomId,
    required String receiverId,
  }) async {
    List<ChatRoom> chatRooms = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {

      Map data = {
        "receiverId": receiverId,
        "text": text,
        "chatRoomId": chatRoomId
      };

      String jsonBody = jsonEncode(data);

      http.Response res = await http.post(
        Uri.parse('$uri/api/send-text'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonBody
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {

          Message newMessage = Message.fromMap(jsonDecode(res.body));
          // Provider.of<ChatRoomProvider>(context, listen: false).addNewMessage(newMessage, chatRoomId);

          },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }



}