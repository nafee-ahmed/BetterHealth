import 'package:better_health/screens/doctor_view_item.dart';
import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class BookingRequest extends StatelessWidget {
  const BookingRequest({ Key? key }) : super(key: key);
  void acceptFunc(){
    return null;
  }

  

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);
    
    void onClickNotification(){
      Navigator.of(context).pushNamed(Routes.notificationPage);
    }
    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopNavBar(onLeftPress: onClickNotification,),
          addSpaceVertically(size.height*0.07),
          Text('Hello there, ', style: themeData.textTheme.headline2,),
          Text('Dr. Mark 👋🏻', style: themeData.textTheme.headline2!.copyWith(fontWeight: FontWeight.w700, color: COLOR_BLACK)),
          addSpaceVertically(size.height*0.04),
          Text('Booking Requests', style: themeData.textTheme.headline3,),
          addSpaceVertically(size.height*0.03),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index){
                return DoctorViewItem(size: size, themeData: themeData, acceptFunc: acceptFunc,);
              },
            ),
          )
        ],
      ),
    );
  }
}