import 'package:better_health/screens/doctor_view_item.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/view_model/messaging_view_model.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/common_functions.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);

    void backPress(){
      Navigator.of(context).pop();
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
        padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
          child: Column(
            children: [
              TopNavBar(iconData: FontAwesomeIcons.arrowLeft, onLeftPress: backPress,),
              PageHeading(themeData: themeData, text: 'Notifications'),
              addSpaceVertically(size.height*0.05),
              Expanded(
                child: StreamBuilder<dynamic>(
                  stream: MessagingViewModel.loadNotifications(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      final List list = [];
                      snapshot.data!.docs.map((DocumentSnapshot doc) {
                        Map m = doc.data() as Map<String, dynamic>;
                        list.add(m);
                      }).toList();
                      if (list.length == 0) {
                        return Text('Nothing to display!', style: themeData.textTheme.displayMedium,);
                      }
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index){
                          String image = 'student_image';
                          if (list[index]['type'] == 'bookingRequest') image = 'booking';
                          else if (list[index]['type'] == 'emergencyRequest') image = 'emergency';
                          return DoctorViewItem(
                            size: size, themeData: themeData, page: 'student', 
                            image: image, 
                            name: list[index]['title'], 
                            text: list[index]['body'],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text(snapshot.error.toString());
                    } else {
                      return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
                    }
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}