import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/my_colors.dart';


class CustomCheckBox extends StatefulWidget {
  bool isChecked;
  final VoidCallback? onChangedCallback; // New property for the callback
  CustomCheckBox({super.key, required this.isChecked, this.onChangedCallback});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.pink;
      }
      return myColors.focusedBorderColorBlue;
    }

    return Checkbox(
      checkColor: myColors.mainBackgroundColor,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: widget.isChecked,
      onChanged: (bool? value) {
        widget.onChangedCallback?.call();
        setState(() {
          widget.isChecked = value!;
          isSignUpPageCheckBoxChecked = value!;
        });
        print(isSignUpPageCheckBoxChecked);
      },
    );
  }
}
