import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/utils.dart';
import 'package:twitter_clone/features/messeges/services/messages_services.dart';
import 'package:twitter_clone/providers/message_provider.dart';
import 'package:twitter_clone/theme/pallete.dart';
import '../../../models/message.dart';
import '../../../providers/user_provider.dart';

class ChatScreen extends StatefulWidget {

  static const String routeName = '/chat-screen';
  const ChatScreen({super.key});

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

    chatRoomId = await messagesService.fetchChatRoomId(context: context, receiverUserId: '6563cd9f89dd370f62f9131f');
    connectToRoom(chatRoomId);

  }

  void connectToRoom(String roomName) {
    socket = IO.io(uri, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();

    socket.onConnect((data) {
      print('user has joined $roomName');
      if (mounted) {
        socket.emit('/join_room', roomName);
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
        'message': text,
        'sender': user.name
      });
    }
  }

  void listenToMessages() {
    socket.on('message', (data) {
      if (mounted) {
        print('Received message: $data');
        // Handle the received message as needed
        showSnackBar(context, data['text']);
        Provider.of<MessageProvider>(context, listen: false).addNewMessage(
            Message.fromJson(data));

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

    return Scaffold(
      backgroundColor: Pallete.greyColor,
      appBar: AppBar(
        title: const Text('Flutter Socket.IO'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MessageProvider>(
              builder: (_, provider, __) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final message = provider.messages[index];
                  return Wrap(
                    alignment: message.senderUsername == name
                        ? WrapAlignment.end
                        : WrapAlignment.start,
                    children: [
                      Card(
                        color: message.senderUsername == name
                            ? Theme.of(context).primaryColorLight
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                            message.senderUsername == name
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(message.message),
                              Text(
                                DateFormat('hh:mm a').format(message.sentAt),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
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