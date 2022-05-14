import 'package:better_health/routes.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/common_functions.dart';
import '../widgets/doctor_list_item.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({ Key? key }) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  void onClickItem(){
    Navigator.of(context).pushNamed(Routes.doctorRequestPage);
  }

  void onClickNotification(){
    Navigator.of(context).pushNamed(Routes.notificationPage);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopNavBar(onLeftPress: onClickNotification,),
          addSpaceVertically(size.height*0.07),
          Text('Hello there, ', style: themeData.textTheme.headline2,),
          Text('Mark 👋🏻', style: themeData.textTheme.headline2!.copyWith(fontWeight: FontWeight.w700, color: COLOR_BLACK)),
          addSpaceVertically(size.height*0.04),
          Text('Top Doctors', style: themeData.textTheme.headline3,),
          addSpaceVertically(size.height*0.03),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index){
                return DoctorListItem(size: size, themeData: themeData, executeOnTap: onClickItem,);
              },
            ),
          ),
        ],
      ),
    );
  }
}
