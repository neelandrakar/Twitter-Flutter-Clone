import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/myTexts.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_button.dart';

class NoMessagesScreen extends StatelessWidget {
  const NoMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to your\ninbox!',
                style: TextStyle(
                  color: Pallete.whiteColorSecond,
                  fontSize: 30,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 10),
              Text(MyTexts.noMessageSmallText,
                style: TextStyle(
                    color: Pallete.postHintColor,
                    fontSize: 14,
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(right: 170),
                child: CustomButton(
                    onClick: (){
                      print('button clicked');
                    },
                    buttonText: 'Write a message',
                    borderRadius: 20,
                    textColor: myColors.mainBackgroundColor,
                    buttonColor: Pallete.whiteColor,
                    height: 35,
                    width: 40,
                ),
              )
            ],
          ),
      ),
    );
  }
}
