import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/my_colors.dart';

class SidebarMenuItems extends StatefulWidget {
  final String menuIcon;
  final String menuName;
  final VoidCallback onClick;
  const SidebarMenuItems({super.key, required this.menuIcon, required this.menuName, required this.onClick});

  @override
  State<SidebarMenuItems> createState() => _SidebarMenuItemsState();
}

class _SidebarMenuItemsState extends State<SidebarMenuItems> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onClick.call();
      },
      child: Container(
        height: 50,
        child: Row(
          children: [
            SvgPicture.asset(widget.menuIcon,color: myColors.whiteColor,height: 25,width: 25,),
            SizedBox(width: 25),
            Text(widget.menuName,
            style: TextStyle(
              color: myColors.whiteColor,
              fontSize: 22,
              fontWeight: FontWeight.w600
            ),)

          ],
        ),
      ),
    );
  }
}
