import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/theme/pallete.dart';

class ProfileTabs extends StatefulWidget {
  final Size size;
  const ProfileTabs({super.key, required this.size});

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new DefaultTabController(
          length: 5,
          child: new Scaffold(
            appBar: PreferredSize(
              preferredSize: widget.size * 0.95,
              child: Container(
                child: SafeArea(
                  child: Column(
                    children: [
                      TabBar(
                        unselectedLabelColor: myColors.mainBackgroundColor,
                          indicatorColor: Pallete.blueColor,
                          labelColor: Pallete.blueColor,
                          isScrollable: true,
                          tabs: [
                            Text('Posts'),
                            Text('Replies'),
                            Text('Highlights'),
                            Text('Media'),
                            Text('Likes'),
                          ]
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                Text('Posts Page'),
                Text('Replies Page'),
                Text('Highlights Page'),
                Text('Media Page'),
                Text('Likes Page'),
              ],
            ),
          )),

    );
  }
}
