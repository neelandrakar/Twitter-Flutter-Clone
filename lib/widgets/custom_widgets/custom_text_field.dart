import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/my_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final int maxLines;
  final Color? textColor;
  final VoidCallback? onClick;
  final bool readOnly;
  final bool isPassword;
  final bool obscureText;
  final Icon? suffixIcons;
  final IconButton? suffixIconPassword;
  final bool isTweetTextField;
  const CustomTextField({Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.textColor,
    this.onChanged,
    this.onClick,
    this.readOnly = false,
    this.isPassword = false,
    this.obscureText = false,
    this.suffixIcons,
    this.suffixIconPassword,
    this.isTweetTextField = false
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onClick,
      readOnly: readOnly,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      cursorColor: myColors.focusedBorderColorBlue,
      style: TextStyle(
        color: textColor ==  null ? myColors.whiteColor : textColor
      ),
      decoration: InputDecoration(
        //hintText: isTweetTextField ? hintText : '',
        suffixIcon: isPassword ? suffixIconPassword : suffixIcons,
        //labelText: isTweetTextField ? '' :hintText,
        labelText: hintText,
        labelStyle: TextStyle(
          color: myColors.greyColor
        ),
        fillColor: myColors.whiteColor,
        border: isTweetTextField ? InputBorder.none : OutlineInputBorder(
          borderSide: BorderSide(
            color: myColors.enabledBorderColor,
          ),
        ),
        enabledBorder: isTweetTextField ? InputBorder.none : OutlineInputBorder(
          borderSide: BorderSide(
            color: myColors.disabledBorderColor,
          ),
        ),

        focusedBorder: isTweetTextField ? InputBorder.none : OutlineInputBorder(
          borderSide: BorderSide(
            color: myColors.focusedBorderColorBlue,
          ),
        ),


        // Set the text color of the input
        hintStyle: TextStyle(
          color: myColors.whiteColor, // Change the hint text color
        ),
        // Set the text color of the input
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        // Adjust the content padding for text alignment
      ),
       validator: (val) {


        if(!isPassword) {
          if (val == null || val.isEmpty) {
            return 'Enter your $hintText';
          }
          return null;
        } else{
          if (val == null || val.isEmpty) {
            return 'Enter your $hintText';
          } else if(val.length<8){
            return 'Password must be atleast 8 characters long';
          }
          return null;
        }
      },
    );
  }
}
