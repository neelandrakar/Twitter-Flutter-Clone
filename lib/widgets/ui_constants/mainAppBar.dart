import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/features/search/widgets/custom_search_bar.dart';
import 'package:twitter_clone/widgets/ui_constants/assets_constants.dart';

import '../../constants/global_variables.dart';
import '../../providers/user_provider.dart';
import '../../theme/pallete.dart';


class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isMainScreen;
  final VoidCallback? openDrawer;
  final bool isSearchScreen;
  const MainAppBar({super.key, this.isMainScreen = false,  this.openDrawer, this.isSearchScreen=false});

  @override
  Widget build(BuildContext context) {

    ImageProvider<Object> backgroundImageProvider = AssetImage(AssetsConstants.searchIcon);

    if(isMainScreen) {
      final user = context
          .watch<UserProvider>()
          .user;
      String userProfilePic = user.profilePicture!;

      if (userProfilePic != '') {
        backgroundImageProvider = NetworkImage(userProfilePic);
      } else {
        backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);
      }
    }


    return AppBar(
        title: SvgPicture.asset(
        'assets/svgs/x_twitter_logo.svg',
        width: 30,
        height: 30,
        color: Colors.white,
      ),
      centerTitle: true,
      actions: [
        if(isSearchScreen)
          Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Icon(Icons.settings,color: Pallete.whiteColorSecond),
        )
      ],
      leading: isMainScreen ? Container(
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
      ) : null,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Pallete.bottomBorderColor,
            height: 1.0,
          ),
        )

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
