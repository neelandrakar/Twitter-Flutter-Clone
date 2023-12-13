import 'package:flutter/cupertino.dart';
import 'package:twitter_clone/widgets/ui_constants/assets_constants.dart';

  bool isSignUpPageCheckBoxChecked = true;
  TextEditingController searchController = TextEditingController();
  TextEditingController messageSearchController = TextEditingController();
  TextEditingController searchPeopleToMessageController = TextEditingController();
  DateTime signUpbirthDate = DateTime.now();
  bool isEmailSelected = false;
  String signUpName = '';
  String signUpUsername = '';
  String signUpEmail = '';
  String signUpPassword = '';
  int signUpPhone = 0;
  String signUpdateOfBirth = '';
  String uri = 'http://192.168.203.6:3000';
  String loginCred = '';
  String tweetedByUsername = '';


  List<Map<String,String>> sideMenus = [
    {
      'name': 'Profile', 'icon': AssetsConstants.homeOutlinedIcon, 'navigation': ''
    },
    {
      'name': 'Premium', 'icon': AssetsConstants.twitterLogo, 'navigation': ''
    },
    {
      'name': 'Bookmarks', 'icon': AssetsConstants.verifiedIcon, 'navigation': ''
    },
    {
      'name': 'Lists', 'icon': AssetsConstants.shareIcon, 'navigation': ''
    },
    {
      'name': 'Spaces', 'icon': AssetsConstants.galleryIcon, 'navigation': ''
    },
    {
      'name': 'Monetization', 'icon': AssetsConstants.gifIcon, 'navigation': ''
    }
  ];

  
