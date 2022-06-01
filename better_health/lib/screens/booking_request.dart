import 'package:better_health/screens/doctor_view_item.dart';
import 'package:better_health/services/bookings/booking_service.dart';
import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/utils/custom_exception.dart';
import 'package:better_health/view_model/auth_view_model.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/currentUser.dart';
import '../routes.dart';

class BookingRequest extends StatefulWidget {
  const BookingRequest({ Key? key }) : super(key: key);

  @override
  State<BookingRequest> createState() => _BookingRequestState();
}

class _BookingRequestState extends State<BookingRequest> {
  Future acceptBookingRequest(String reqID, BuildContext context, Function setter) async {
    try {
      BookingService.acceptBookingRequest(reqID);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking request accepted.'))
      );
      setter();
    } on CustomException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!))
      );
      print(e.message);
    }
  }

  Future rejectBookingRequest(String reqID, BuildContext context, Function setter) async {
    try {
      BookingService.rejectBookingRequest(reqID);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking request accepted.'))
      );
      setter();
    } on CustomException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!))
      );
      print(e.message);
    }
  }

  Function? setter() {
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);
    AuthViewModel.getDoctorCurrentUser(context);
    
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
          Consumer<CurrentUser>(
            builder: (context, value, child){
              return value.name == '' && value.email == ''
              ? CircularProgressIndicator(color: COLOR_PRIMARY,)
              : Text('Dr. ${value.name} 👋🏻', style: themeData.textTheme.headline2!.copyWith(fontWeight: FontWeight.w700, color: COLOR_BLACK));
            }
          ),
          addSpaceVertically(size.height*0.04),
          Text('Booking Requests', style: themeData.textTheme.headline3,),
          addSpaceVertically(size.height*0.03),
          Expanded(
            child: StreamBuilder<dynamic>(
              stream: BookingService.getBookingRequestList(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List list = snapshot.data;
                  if (list.length == 0) return Column(
                    children: [
                      Text('Nothing to display!', style: themeData.textTheme.displayMedium,),
                      addSpaceVertically(size.height * 0.02),
                      Text(
                        'Wait for students to send booking requests through the schedule you set',
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index){
                      return 
                      DoctorViewItem(
                        size: size, themeData: themeData, 
                        acceptFunc: () => acceptBookingRequest(list[index]['id'], context, setter), 
                        rejectFunc: () => rejectBookingRequest(list[index]['id'], context, setter),
                        name: list[index]['studentName'], 
                        text: list[index]['day'] + ', ' + list[index]['date'] + ' ' + list[index]['month'] + ' ' + list[index]['year'] + ', ' + ' ' + list[index]['time'],
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
    );
  }
}