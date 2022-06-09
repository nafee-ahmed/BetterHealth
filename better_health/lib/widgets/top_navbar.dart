import 'package:better_health/services/user/my_user.dart';
import 'package:better_health/view_model/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopNavBar extends StatefulWidget {
  const TopNavBar({
    Key? key,
    this.iconData = FontAwesomeIcons.solidBell,
    this.onLeftPress,
  }) : super(key: key);

  final IconData iconData;
  final Function? onLeftPress;

  @override
  State<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: (){
            if(widget.onLeftPress != null) widget.onLeftPress!();
          }, 
          icon: FaIcon(widget.iconData), 
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () => AuthViewModel.logoutPress(context), 
          icon: FaIcon(FontAwesomeIcons.powerOff), 
        ),
      ],
    );
  }
}