import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/auth/screens/login_screen_two.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_button.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_text_field.dart';
import 'package:twitter_clone/widgets/ui_constants/mainAppBar.dart';
import 'package:twitter_clone/constants/myTexts.dart';

class LoginScreenOne extends StatefulWidget {
  static const String routeName = '/login-screen-one';
  const LoginScreenOne({super.key});

  @override
  State<LoginScreenOne> createState() => _LoginScreenOne();
}

class _LoginScreenOne extends State<LoginScreenOne> {
  @override
  Widget build(BuildContext context) {
    bool isTextFieldFilled = true;
    Color nextButtonColor = myColors.greyColor;
    final TextEditingController _usernameController = TextEditingController();
    final _checkUsernameKey = GlobalKey<FormState>();

    void updateButtonColor() {
      setState(() {
        if (_usernameController.text.isNotEmpty) {
          nextButtonColor =
              myColors.mainBackgroundColor; // Change color when text is typed
        } else {
          nextButtonColor =
              myColors.greyColor; // Set default color when the field is empty
        }
      });
    }

    void navigateToLoginTwoPage(){

      Navigator.pushNamed(context, LoginScreenTwo.routeName);
    }

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
                    key: _checkUsernameKey,
                    child: CustomTextField(
                      controller: _usernameController,
                      hintText: 'Phone,email, or username',
                      // onChanged: (text) {
                      //   updateButtonColor();
                      // },
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
                          if (_checkUsernameKey.currentState!.validate()) {
                            loginCred = _usernameController.text;
                            navigateToLoginTwoPage();
                          }
                        },
                        buttonText: 'Next',
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
