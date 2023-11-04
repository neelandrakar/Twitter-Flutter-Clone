import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/myTexts.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/auth/screens/signup_screen_four.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_check_box.dart';
import 'package:twitter_clone/widgets/ui_constants/mainAppBar.dart';

import '../../../widgets/custom_widgets/custom_button.dart';

class SignUpScreenThree extends StatefulWidget {
  static const String routeName = '/signup-screen-three';
  const SignUpScreenThree({super.key});

  @override
  State<SignUpScreenThree> createState() => _SignUpScreenThreeState();
}

class _SignUpScreenThreeState extends State<SignUpScreenThree> {

  Color nextButtonColor = myColors.greyColor;

  void changeNextButtonColor(){
    if(!isSignUpPageCheckBoxChecked) {
      setState(() {
        nextButtonColor = myColors.whiteColor;
      });
    } else{
      setState(() {
        nextButtonColor = myColors.greyColor;
      });
    }
  }

  void navigateToSignUpFourPage(){
    Navigator.pushNamed(context, SignUpScreenFour.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customize your experience',
              style: TextStyle(
                  color: myColors.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 30,),
            Text(
              'Track where you see X content across the web',
              style: TextStyle(
                  color: myColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 230,
                  child: Text(
                    MyTexts.signUpPageCheckBoxText,
                    maxLines: 5,
                    style: TextStyle(
                      fontSize: 14,
                      color: myColors.whiteColor,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                CustomCheckBox(
                    isChecked: isSignUpPageCheckBoxChecked,
                    onChangedCallback: (){
                      changeNextButtonColor();
                    }
                )
              ],
            ),
            SizedBox(height: 30),
            Text(MyTexts.termsAndConditionsLong,
              style: TextStyle(
                  color: myColors.greyColor,
                  fontSize: 12
              ),),

            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                  onClick: () {
                    if(isSignUpPageCheckBoxChecked){
                      //navigate to username and password page
                      print(signUpName);
                      print(signUpPhone);
                      print(signUpEmail);
                      print(signUpdateOfBirth);
                      navigateToSignUpFourPage();
                    }

                  },
                  buttonText: 'Next',
                  height: 30,
                  width: 30,
                  borderRadius: 20,
                  buttonColor: nextButtonColor,
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
