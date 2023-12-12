import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/auth/services/auth_services.dart';
import 'package:twitter_clone/features/home/screens/home_screen.dart';
import 'package:twitter_clone/providers/message_provider.dart';
import 'package:twitter_clone/providers/tweet_provider.dart';
import 'package:twitter_clone/providers/user_provider.dart';
import 'package:twitter_clone/router.dart';
import 'package:twitter_clone/providers/user_provider.dart';
import 'package:twitter_clone/widgets/ui_constants/bottom_bar.dart';
import 'features/auth/screens/login_screen_one.dart';
import 'features/auth/screens/signup_screen_one.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> UserProvider()),
        ChangeNotifierProvider(create: (context)=> TweetProvider()),
        ChangeNotifierProvider(create: (context)=> MessageProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authServices = AuthServices();

  loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    print('Fetched token is $token');
  }

  @override
  void initState() {

    Future.delayed(Duration.zero,() {
      authServices.getUserData(context);
    });
    loadUsername();
    // TODO: implement initState
    super.initState();

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'X Clone',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData(
        scaffoldBackgroundColor: myColors.mainBackgroundColor,
        colorScheme:
          ColorScheme.light(secondary: Colors.grey),
        appBarTheme:AppBarTheme(
          elevation: 0,backgroundColor: myColors.mainBackgroundColor
        )
      ),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? BottomBar()
          : SignUpScreenOne(),
    );
  }
}

