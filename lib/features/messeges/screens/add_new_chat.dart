import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/messeges/services/messages_services.dart';
import 'package:twitter_clone/features/messeges/widgets/text_new_user_card.dart';
import 'package:twitter_clone/features/search/widgets/custom_search_bar.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:twitter_clone/widgets/ui_constants/assets_constants.dart';

import '../../../models/user.dart';

class AddNewChat extends StatefulWidget {
  static const String routeName = '/add-new-chat-screen';
  const AddNewChat({super.key});

  @override
  State<AddNewChat> createState() => _AddNewChatState();
}

class _AddNewChatState extends State<AddNewChat> {

  List<User>? chatSuggestions = [];
  final MessagesService messagesService = MessagesService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchPeopleToMessageController.clear();
    setState(() {
      chatSuggestions = [];
    });
  }

  void fetchChatSuggestions() async{
    chatSuggestions = await messagesService.fetchChatSuggestions(context: context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchChatSuggestions();
    });

    // listenToMessages();
  }

  @override
  Widget build(BuildContext context) {

    void searchPeopleToMessage(String query) async{
      print(query);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Direct Message',
          style: TextStyle(
            color: Pallete.whiteColorSecond
          ),
        ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Pallete.bottomBorderColor,width: 1),
                      bottom: BorderSide(color: Pallete.bottomBorderColor,width: 1)
                  )
              ),
              child: CustomSearchBar(
                  hintText: '',
                  backgroundColor: Colors.white10,
                  fullBackGroundColor: myColors.mainBackgroundColor,
                  hintColor: myColors.mainBackgroundColor,
                  controller: searchPeopleToMessageController,
                  onSubmit: searchPeopleToMessage,
                  height: 50,
                  width: double.infinity,
                  isAddNewChatPage: true,
            ),
          )
      ),

    ),
      body: Column(
          children: [
            GestureDetector(
              onTap: (){
                print('Create group button is clicked');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Pallete.blueColor,width: 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(AssetsConstants.groupIcon,color: Pallete.blueColor,),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Text(
                      'Create a group',
                      maxLines: 1,
                      style: TextStyle(
                        color: Pallete.blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: chatSuggestions!.length>0 ? ListView.builder(
                  itemCount: chatSuggestions!.length,
                  itemBuilder: (context, index){
                  return TextNewUserCard(user: chatSuggestions![index]);
                  }) : SpinKitRing(color: Pallete.blueColor,lineWidth: 4,size: 40,)
              ),
          ],
        ),
    );
  }
}
