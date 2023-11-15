import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/constants/my_colors.dart';

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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: backgroundImageProvider,
                                  radius: 20,
                                ),
                                SizedBox(height: 5),
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
                                      fontSize: 16,
                                      color: myColors.greyColor
                                  ),
                                ),
                              ],

                            )
                          ],
                        )
                      ],
                    ),
                  ),

                ));

  }
}
