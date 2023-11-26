import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class HashTagText extends StatelessWidget {
  final String text;
  final Color textColor;
  const HashTagText({super.key, required this.text, this.textColor=Pallete.whiteColor});

  @override
  Widget build(BuildContext context) {

    List<TextSpan> textSpans = [];

    text.split(' ').forEach((element) {
      if(element.startsWith('#') || element.startsWith('@')){
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: TextStyle(
              color: Pallete.blueColor,
              fontSize: 14,
              fontWeight: FontWeight.bold
            )
          )
        );
      } else if(element.startsWith('www.') || element.startsWith('https://')){
        textSpans.add(
            TextSpan(
                text: '$element ',
                style: TextStyle(
                    color: Pallete.blueColor,
                    fontSize: 14,
                )
            )
        );
      } else{
        textSpans.add(
            TextSpan(
                text: '$element ',
                style: TextStyle(
                    fontSize: 14,
                    color: textColor
                )
            )
        );
      }
    });

    return RichText(
        text: TextSpan(
          children: textSpans
        ));
  }
}
