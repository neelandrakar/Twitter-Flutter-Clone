import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/pallete.dart';

class TweetIconButton extends StatefulWidget {
  String pathName;
  String text;
  VoidCallback onTap;
  Color color;

  // Constructor without final keyword
  TweetIconButton({
    Key? key,
    this.pathName = '',
    this.text = '',
    required this.onTap,
    this.color = Pallete.greyColor,
  }) : super(key: key);

  @override
  State<TweetIconButton> createState() => _TweetIconButtonState();
}

class _TweetIconButtonState extends State<TweetIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            widget.pathName,
            color: widget.color,
            height: 18,
          ),
          Container(
            margin: const EdgeInsets.only(right: 6, top: 6, bottom: 6, left: 3),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 13,
                color: widget.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
