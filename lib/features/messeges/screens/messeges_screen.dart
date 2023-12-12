import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/features/messeges/screens/chat_list.dart';
import 'package:twitter_clone/features/messeges/screens/chat_screen.dart';
import 'package:twitter_clone/features/messeges/services/messages_services.dart';
import 'package:twitter_clone/features/messeges/widgets/no_messages_screen.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_button.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../../theme/pallete.dart';
import '../../../widgets/ui_constants/assets_constants.dart';
import '../../search/widgets/custom_search_bar.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  bool beforeSearch = true;
  ImageProvider<Object> backgroundImageProvider = AssetImage(AssetsConstants.searchIcon);
  final MessagesService messagesService = MessagesService();
  bool hasUserChatted = false;

  void fetchHasUserChatted() async{
    hasUserChatted = await messagesService.fetchUserChatStatus(context: context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchHasUserChatted();
    });

    // listenToMessages();
  }



  @override
  Widget build(BuildContext context) {


    final user = context
        .watch<UserProvider>()
        .user;
    String userProfilePic = user.profilePicture!;
    if (userProfilePic != '') {
      backgroundImageProvider = NetworkImage(userProfilePic);
    } else {
      backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);
    }

    void searchMessages(String query) async{

      print(query);
    }

    return Scaffold(
      appBar: AppBar(
          title: CustomSearchBar(
            hintText: 'Search Direct Messages',
            backgroundColor: Pallete.greyColor,
            hintColor: Pallete.whiteColorSecond,
            controller: messageSearchController,
            onSubmit: searchMessages,
          ),
          leading: beforeSearch ? Container(
            margin: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
              child: CircleAvatar(
                backgroundImage: backgroundImageProvider,
                radius: 15,
              ),
            ),
          ) : Icon(Icons.arrow_back,color: Pallete.whiteColorSecond,size: 14,),
          actions: [
            beforeSearch ? Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.settings,color: Pallete.whiteColor),
            ) : Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.more_vert_outlined, color: Pallete.whiteColor,),
            ),
            // Padding(
            //   padding: EdgeInsets.only(right: 10.0),
            //   child: Icon(Icons.ac_unit, color: Pallete.whiteColor,),
            // ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Pallete.bottomBorderColor,width: 1)
                  )
              ),
            ),
          )
      ),
      body: hasUserChatted ? ChatList() : NoMessagesScreen()
    );
  }
}
