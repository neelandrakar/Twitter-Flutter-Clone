import 'package:flutter/material.dart';
import 'package:twitter_clone/features/home/screens/home_screen.dart';
import 'package:twitter_clone/features/notification/screens/notification_screen.dart';
import 'package:twitter_clone/features/search/search_screen.dart';

class BottomNavBarPages{

    static List<Widget> allWidgets = [

      HomeScreen(),
      SearchScreen(),
      NotificationScreen()

    ];
}