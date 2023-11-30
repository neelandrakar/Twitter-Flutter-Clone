import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final Color backgroundColor;
  final Color hintColor;
  final void Function(String) onSubmit;
  final TextEditingController controller;
  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.backgroundColor,
    required this.hintColor,
    required this.controller,
    required this.onSubmit
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {

    bool isDark = false;
    // searchController.text = 'Eden Hazard';

    return SizedBox(
      height: 35,
      width: 250,
      child: TextField(
        onSubmitted: (String input){
          widget.onSubmit(input);
        },
        style: TextStyle(
          color: Pallete.whiteColorSecond
        ),
        cursorColor: Pallete.blueColor,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: EdgeInsets.all(0).copyWith(left: 13),
          fillColor: Pallete.searchFieldColor,
          filled: true,
          hintMaxLines: 1,
          hintStyle: TextStyle(color: Pallete.postHintColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 0
            )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
              width: 0
          )
      ),
          // Add a clear button to the search bar
        ),
      ),
    );

  }
}
