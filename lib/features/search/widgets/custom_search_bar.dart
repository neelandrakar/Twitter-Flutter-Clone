import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final Color backgroundColor;
  final Color hintColor;
  final Color fullBackGroundColor;
  final double height;
  final double width;
  final isAddNewChatPage;
  final void Function(String) onSubmit;
  final TextEditingController controller;
  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.backgroundColor,
    required this.hintColor,
    required this.controller,
    required this.onSubmit,
    this.width = 250,
    this.height = 35,
    this.fullBackGroundColor = Pallete.searchBarColor,
    this.isAddNewChatPage = false
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
      height: widget.height,
      width: widget.width,
      child:TextField(

            onSubmitted: (String input){
              widget.onSubmit(input);
            },
            style: TextStyle(
              color: Pallete.whiteColorSecond
            ),
            cursorColor: Pallete.blueColor,
            controller: widget.controller,
            decoration: InputDecoration(
              prefixIcon: widget.isAddNewChatPage ? Icon(Icons.search_outlined,color: Pallete.postHintColor,size: 25,) : null,
              hintText: widget.hintText,
              contentPadding: EdgeInsets.all(0).copyWith(left: 13),
              fillColor: widget.fullBackGroundColor,
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
