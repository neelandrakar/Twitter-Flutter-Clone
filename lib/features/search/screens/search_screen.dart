import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/features/search/services/search_services.dart';
import 'package:twitter_clone/features/search/widgets/custom_search_bar.dart';
import 'package:twitter_clone/features/search/widgets/topic_card.dart';
import 'package:twitter_clone/features/search/widgets/topic_viewer.dart';
import 'package:twitter_clone/features/search/widgets/tweet_viewer.dart';
import 'package:twitter_clone/models/tweets.dart';
import 'package:twitter_clone/widgets/ui_constants/mainAppBar.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../../theme/pallete.dart';
import '../../../widgets/ui_constants/assets_constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  ImageProvider<Object> backgroundImageProvider = AssetImage(AssetsConstants.searchIcon);

  bool beforeSearch = true;
  List<Tweets> allTweets = [];




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

  String tab1 = beforeSearch ? 'For you' : 'Top';
  String tab2 = beforeSearch ? 'Trending' : 'Latest';
  String tab3 = beforeSearch ? 'News' : 'People';
  String tab4 = beforeSearch ? 'Sports' : 'Media';
  String tab5 = beforeSearch ? 'Entertainment' : 'List';

  final SearchServices searchServices = SearchServices();


  void clickSearch(String query) async{

    beforeSearch ? print('failed') : print('success with $query');
    allTweets = await searchServices.fetchTopTweets(context: context, searchedQuery: query);
    beforeSearch = false;
    print('length ${allTweets.length}');
    setState(() {});
    print('length2 ${allTweets.length}');

  }


  return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            title: CustomSearchBar(
              hintText: 'Search X',
              backgroundColor: Pallete.greyColor,
              hintColor: Pallete.whiteColorSecond,
              controller: searchController,
              onSubmit: clickSearch,
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
                preferredSize: Size.fromHeight(35),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Pallete.bottomBorderColor,width: 1)
                      )
                  ),
                  child: TabBar(

                      unselectedLabelColor: Pallete.postHintColor,
                      indicatorColor: Pallete.blueColor,
                      labelColor: Pallete.whiteColorSecond,
                      // labelStyle: TextStyle(
                      //   fontSize: 20
                      // ),
                      isScrollable: true,
                      tabs: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(tab1,
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(tab2,
                            style: TextStyle(
                                fontSize: 16
                            ),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(tab3,
                            style: TextStyle(
                                fontSize: 16
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(tab4,
                            style: TextStyle(
                                fontSize: 16
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(tab5,
                            style: TextStyle(
                                fontSize: 16
                            ),),
                        ),
                      ]
                  ),
                ),
              )
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 0),
            Expanded(
              child: TabBarView(
                children: [
                  beforeSearch ? TopicViewer(tabNo: 0) : TweetViewer(allTweets: allTweets),
                  Text('Trending Screen',style: TextStyle(color: Pallete.whiteColor),),
                  Text('News Screen',style: TextStyle(color: Pallete.whiteColor),),
                  TopicViewer(tabNo: 3),
                  Text('Entertainment Screen',style: TextStyle(color: Pallete.whiteColor),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
