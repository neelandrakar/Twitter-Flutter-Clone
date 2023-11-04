import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/myTexts.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/auth/screens/login_screen_one.dart';
import 'package:twitter_clone/features/auth/screens/signup_screen_two.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_button.dart';
import 'package:twitter_clone/widgets/ui_constants/mainAppBar.dart';

class SignUpScreenOne extends StatelessWidget {
  static const String routeName = '/signup-screen-one';
  const SignUpScreenOne({super.key});

  @override
  Widget build(BuildContext context) {


    void navigateToLoginPage(){
      Navigator.pushNamed(context, LoginScreenOne.routeName);
    }

    void navigateToSignUpTwoPage(){
      Navigator.pushNamed(context, SignUpScreenTwo.routeName);
    }

    return Scaffold(
      appBar: MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(height: 110,),
            Text(MyTexts.signUpScreenText,
              style: TextStyle(
                color: myColors.whiteColor,
                fontSize: 33,
                fontWeight: FontWeight.w700
              ),),
            SizedBox(height: 100),
            CustomButton(
              onClick: (){},
              buttonText: 'Continue with Google',
              borderRadius: 20,
              buttonColor: myColors.whiteColor,
              textColor: myColors.mainBackgroundColor,
              height: 40,
              width: double.infinity),
            Row(
              children: [
                Container(height: 1,width:130,color: Colors.white30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('or',style: TextStyle(color: Colors.white30),),
                ),
                Container(height: 1,width:130,color: Colors.white30,),
              ],
            ),
            CustomButton(
                onClick: (){
                  navigateToSignUpTwoPage();
                },
                buttonText: 'Create Account',
                borderRadius: 20,
                buttonColor: myColors.whiteColor,
                textColor: myColors.mainBackgroundColor,
                height: 40,
                width: double.infinity),
            SizedBox(height: 50,),
            Text(MyTexts.termsAndConditionsShort,
            style: TextStyle(
              color: myColors.greyColor,
              fontSize: 12
            ),),
            SizedBox(height: 50,),
            Row(
              children: [
                Text('Have an account already?',
                  style: TextStyle(
                      color: myColors.greyColor,
                      fontSize: 15
                  ),),
                SizedBox(width: 5,),
                InkWell(
                  onTap: navigateToLoginPage,
                  child: Text('Log in',
                    style: TextStyle(
                        color: myColors.focusedBorderColorBlue,
                        fontSize: 15
                    ),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
