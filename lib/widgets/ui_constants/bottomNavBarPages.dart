import 'package:flutter/material.dart';
import 'package:twitter_clone/features/home/screens/home_screen.dart';
import 'package:twitter_clone/features/messeges/screens/chat_screen.dart';
import 'package:twitter_clone/features/messeges/screens/messeges_screen.dart';
import 'package:twitter_clone/features/notification/screens/notification_screen.dart';
import 'package:twitter_clone/features/search/screens/search_screen.dart';

class BottomNavBarPages{

    static List<Widget> allWidgets = [

      HomeScreen(),
      SearchScreen(),
      Center(child: Text('Community',style: TextStyle(color: Colors.white),),),
      NotificationScreen(),
      MessagesScreen()

    ];
}