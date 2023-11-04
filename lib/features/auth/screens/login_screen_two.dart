import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/my_colors.dart';

import '../../../constants/myTexts.dart';
import '../../../widgets/custom_widgets/custom_button.dart';
import '../../../widgets/custom_widgets/custom_text_field.dart';
import '../../../widgets/ui_constants/mainAppBar.dart';
import '../services/auth_services.dart';

class LoginScreenTwo extends StatefulWidget {
  static const String routeName = '/login-screen-two';
  const LoginScreenTwo({super.key});

  @override
  State<LoginScreenTwo> createState() => _LoginScreenTwoState();
}

class _LoginScreenTwoState extends State<LoginScreenTwo> {


  Color nextButtonColor = myColors.greyColor;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _checkUsernamePasswordKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final AuthServices authServices = AuthServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController.text = loginCred;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              children: [
                Text(
                  MyTexts.loginPageOneText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: _checkUsernamePasswordKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _usernameController,
                        hintText: 'Phone,email, or username',
                        // onChanged: (text) {
                        //   updateButtonColor();
                        // },
                      ),
                      SizedBox(height: 30),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        isPassword: true,
                        obscureText: _obscureText,
                        suffixIconPassword: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,size: 18,),
                          color: myColors.greyColor,
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: [
                Container(height: 1,color: Colors.white12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onClick: () {},
                      buttonText: 'Forgot password?',
                      borderRadius: 20,
                      height: 30,
                      width: 50,
                      buttonColor: myColors.mainBackgroundColor,
                      textColor: myColors.whiteColor,
                      borderColor: myColors.whiteColor,
                    ),
                    CustomButton(
                      onClick: () {
                        if (_checkUsernamePasswordKey.currentState!.validate()) {

                          print(_usernameController.text);
                          print(_passwordController.text);

                          authServices.signIn(
                              context: context,
                              userInput: _usernameController.text,
                              password: _passwordController.text);
                        }
                      },
                      buttonText: 'Login',
                      height: 30,
                      width: 30,
                      borderRadius: 20,
                      buttonColor: nextButtonColor,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
