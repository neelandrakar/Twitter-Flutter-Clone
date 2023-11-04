import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class RoundedSmallButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const RoundedSmallButton({
    super.key,
    required this.onTap,
    required this.label,
    this.backgroundColor = Pallete.whiteColor,
    this.textColor = Pallete.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 11,
        ),
        child: InkWell(
          onTap: onTap,
          child: Chip(
            label: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            backgroundColor: backgroundColor,
          ),
        ),
    );
  }
}