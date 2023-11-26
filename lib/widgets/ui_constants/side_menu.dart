import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/profile/screens/profile_screen.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:twitter_clone/widgets/ui_constants/sidebar_menu_items.dart';

import '../../providers/user_provider.dart';
import 'assets_constants.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context, listen: false).user;


    void navigateToProfilePage(){

      Navigator.pushNamed(context, ProfileScreen.routeName);
    }

    int countOfFollowing = user.user_followed!.length;
    int countOfFollowers = user.followed_by!.length;

    String userProfilePic = user.profilePicture!;
    ImageProvider<Object> backgroundImageProvider = AssetImage(AssetsConstants.searchIcon);

    if (userProfilePic != '') {
      backgroundImageProvider = NetworkImage(userProfilePic);
    } else {
      backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);
    }

    return SafeArea(
              child:
                Container(
                  width: 288,
                  height: double.infinity,
                  color: myColors.mainBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: backgroundImageProvider,
                                  radius: 20,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  user.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: myColors.whiteColor
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  '@${user.username}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: myColors.greyColor
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                      Text(countOfFollowing.toString(),
                                      style: TextStyle(
                                        color: myColors.whiteColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),),
                                      SizedBox(width: 3),
                                      Text('Following',
                                        style: TextStyle(
                                            color: myColors.greyColor,
                                            fontSize: 16
                                        ),),
                                      SizedBox(width: 10),
                                    Text(countOfFollowers.toString(),
                                      style: TextStyle(
                                          color: myColors.whiteColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    SizedBox(width: 3),
                                    Text('Followers',
                                      style: TextStyle(
                                          color: myColors.greyColor,
                                          fontSize: 16
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: myColors.mainBackgroundColor,
                                border: Border.all(color: myColors.greyColor,width: 2)
                              ),
                              height: 23,
                              width: 23,
                              child: Icon(
                                Icons.more_vert,
                                color: myColors.greyColor,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Divider(height: 2,thickness: 1,color: Pallete.bottomBorderColor,),
                        SizedBox(height: 30,),
                        Expanded(
                          child: ListView.builder(
                              itemCount: sideMenus.length,
                              itemBuilder: (context,index){

                                void itemClick(int i) {
                                  print('xxx');
                                  if (i == 0) {
                                    navigateToProfilePage();
                                  } else if (i == 2) {
                                    print('neel');
                                  } else {
                                    print('others');
                                  }
                                }
                            return SidebarMenuItems(
                                menuIcon: sideMenus[index]['icon']!,
                                menuName: sideMenus[index]['name']!,
                                onClick: () => itemClick(index)
                            );
                          }),
                        ),
                        SizedBox(height: 30,),
                        Divider(height: 2,thickness: 1,color: Pallete.bottomBorderColor,),
                      ],
                    ),
                  ),

                ));

  }
}
