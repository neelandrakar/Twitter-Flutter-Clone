import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/home/screens/home_screen.dart';
import 'package:twitter_clone/features/tweet/screens/create_tweet_screen.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:twitter_clone/widgets/ui_constants/assets_constants.dart';
import 'package:twitter_clone/widgets/ui_constants/bottomNavBarPages.dart';
import 'package:twitter_clone/widgets/ui_constants/mainAppBar.dart';
import 'package:twitter_clone/widgets/ui_constants/side_menu.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _page = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  void onPageChange(int index){

    setState(() {
      _page = index;
    });
  }

  void navigateToCreateTweetScreen(){

    Navigator.pushNamed(context, CreateTweetScreen.routeName);
}

  @override
  Widget build(BuildContext context) {



    return WillPopScope(
        onWillPop: () async {
          return false;
          },
        child: Scaffold(
          drawer: Drawer(
            backgroundColor: myColors.mainBackgroundColor,
              child: SideMenu(),
            width: 280,
          ),
          body: IndexedStack(
            index: _page,
            children: BottomNavBarPages.allWidgets

          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Pallete.blueColor,
            onPressed: (){
              navigateToCreateTweetScreen();
            },
            child: const Icon(
              Icons.add,
              color: myColors.whiteColor,
              size: 28,
            ),
          ),
          appBar:
              _page==1 ? null :
            MainAppBar(
              isMainScreen: true,
              isSearchScreen: _page==1 ? true : false,
              openDrawer: (){
                print('drawer Opened');
               // Scaffold.of(context).openDrawer();

              }),
          bottomNavigationBar: CupertinoTabBar(
            backgroundColor: myColors.mainBackgroundColor,
            currentIndex: _page,
            onTap: onPageChange,
            border: Border(
              top: BorderSide(
                color: Pallete.bottomBorderColor
              )
            ),

            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _page == 0 ? AssetsConstants.homeFilledIcon : AssetsConstants.homeOutlinedIcon,
                    color: myColors.whiteColor,)),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _page == 1 ? AssetsConstants.searchIcon : AssetsConstants.searchIcon,
                    color: myColors.whiteColor,)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people,color: Pallete.whiteColor,)),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _page == 2 ? AssetsConstants.notifFilledIcon : AssetsConstants.notifOutlinedIcon,
                    color: myColors.whiteColor,)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mail_outline,color: Pallete.whiteColor,)),
            ],

          ),
        ));
  }
}
