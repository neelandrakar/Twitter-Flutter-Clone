import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/features/home/screens/home_screen.dart';
import 'package:twitter_clone/widgets/ui_constants/bottom_bar.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/http_error_handle.dart';
import '../../../constants/utils.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';


class AuthServices {

  Future<void> getDeviceIP() async {
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            print('Device IP address: ${addr.address}');
            return;
          }
        }
      }
      print('Device IP address not found.');
    } catch (e) {
      print('Error getting device IP: $e');
    }
  }


  void checkExistingUser({
    required BuildContext context,
     String? emailAddress,
     required String username,
     int? mobno,
    required VoidCallback nextPage,
  }) async {
    try {
      http.Response res = await http
          .post(Uri.parse('$uri/api/checkExistingUser/'), //Calling the sign up API
          body: jsonEncode({'email': emailAddress, 'mobno': mobno, 'username': username}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            print(res.body);
          nextPage();


          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }
 }

   void signUp({
     required BuildContext context,
     required String name,
     required String username,
     required String email,
     required int mobno,
     required String password,
     required String birthDate
  }) async{

    try{

      User user = User(
        id: "",
        name: name,
        username: username,
        email: signUpEmail,
        mobno: mobno,
        birthDate: birthDate,
        password: password,
        token: ""
      );

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',

          });
      
      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: (){

            signIn(context: context, userInput: username, password: password);

            showSnackBar(
              context,
              "Account has been created...",
            );
          });


    }catch(e){
      print("Error $e");
      showSnackBar(context, e.toString());
    }
  }

  void signIn({

    required BuildContext context,
    //String? email,
    required String userInput,
    //int? mobno,
    required String password,

  }) async{

    try{

      http.Response res = await http.
          post(Uri.parse('$uri/api/signin'),
        body: jsonEncode({
            'userInput': userInput,
            //'email': email,
            //'mobno': mobno,
            'password': password
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async{

            print('Signed in successfully');

            //Setting userProvider
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            print('My token is ${jsonDecode(res.body)['token']}');

            //Creating SP
            final signInSP = await SharedPreferences.getInstance();
            await signInSP.setString('x-auth-token', jsonDecode(res.body)['token']);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomBar(),
              ),
            );


          });



    }catch(e){
      print("Error $e");
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
      BuildContext context) async {

    try{

      final signInSP = await SharedPreferences.getInstance();
      String? token = signInSP.getString('x-auth-token');

      print('user token $token');

      if (token == null) {
        signInSP.setString('x-auth-token', '');
      }

      var tokenRes = await http
        .post(Uri.parse('$uri/checkToken'),

        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        });

      var response = jsonDecode(tokenRes.body);
      print('response: $response');

      if(response==true){

        http.Response userResp = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        print('this part');

        print(userResp.body);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResp.body);
        bool tokenStatus = Provider.of<UserProvider>(context, listen: false)
            .user
            .token
            .isNotEmpty;

        print("Service is started $tokenStatus");
      }

    }catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }

  }

  void getUserData_(BuildContext context) async {
    print('get user data method ran');
    try {
      // SharedPreferences.resetStatic();
      final signInSP = await SharedPreferences.getInstance();
      String? token = signInSP.getString('x-auth-token');

      print('saved token is $token');

      // if (token == '') {
      //   print('token is blank');
      // }

      if (token == null) {
        signInSP.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/checkToken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userResp = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResp.body);
        bool tokenStatus = Provider.of<UserProvider>(context, listen: false)
            .user
            .token
            .isNotEmpty;
        print(token);
        print("Service is started $tokenStatus");
      }
    } catch (e) {
      print(e);
    }
  }
}