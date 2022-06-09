import 'package:better_health/models/selected_doctor.dart';
import 'package:better_health/screens/schedule_screen.dart';
import 'package:better_health/services/services.dart';
import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/utils/custom_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingViewModel {
  static Function? addScheduleButton(BuildContext context, final eventController,
  Map<DateTime, List<String>> selectedEvents, var selectedDay, Function setter){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Add times for the selected date'),
      content: TextFormField(
        decoration: InputDecoration(hintText: 'e.g 9: 00 AM', focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: COLOR_PRIMARY))),
        controller: eventController,
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(primary: COLOR_PRIMARY),
          onPressed: () => Navigator.of(context).pop(), 
          child: Text('Cancel')
        ),
        TextButton(
          style: TextButton.styleFrom(primary: COLOR_PRIMARY),
          onPressed: () async {
            if(eventController.text.isEmpty) {
              Navigator.of(context).pop();
              return;
            } else {
              if(selectedDay == null && selectedEvents[selectedDay] == null){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Select a day first...'))
                );
                return;
              };
              if (selectedEvents[selectedDay] != null) {
                selectedEvents[selectedDay]!.add(eventController.text);
              } else {
                selectedEvents[selectedDay] = [eventController.text];
              }
            }
            Navigator.of(context).pop();
            eventController.clear();
            setter();
            await BookingService.sendDoctorSchedule(selectedEvents);
            return;
          }, 
          child: Text('Okay')
        ),
      ],
    ));
    print(selectedDay);
    return null;
  }

  static Future getSchedules() async {
    return BookingService.getSchedules();
  }

  static Future getScheduleByID(String id) async {
    return BookingService.getScheduleByID(id);
  }

  static Future sendBookingRequest(int index, Function? setter, String selectedTime, BuildContext context,
  Map<DateHolder, List<dynamic>> scheduleMap, ) async {
    if (selectedTime == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Select a time first.'))
      );
      return;
    }
    try {
      String date = scheduleMap.keys.elementAt(index).date;
      String day = scheduleMap.keys.elementAt(index).day;
      String month = scheduleMap.keys.elementAt(index).month;
      String year = scheduleMap.keys.elementAt(index).year;
      print(date + ' ' + day + ' ' + month + ' ' + year + ' ' + selectedTime);
      await BookingService.sendBookingRequest(date, day, month, year, selectedTime, 
      context.read<SelectedDoctor>().id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking request sent to the doctor. Please wait for the doctor\'s response'))
      );
      setter!();
    } on CustomException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!))
      );
    }
    // print(selectedTime);
  }

  static Future editBookingRequest(int index, String selectedTime, Function? setter,
  BuildContext context, Map<DateHolder, List<dynamic>> scheduleMap,) async {
    if (selectedTime == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Select a time first.'))
      );
      return;
    }
    try {
      String date = scheduleMap.keys.elementAt(index).date;
      String day = scheduleMap.keys.elementAt(index).day;
      String month = scheduleMap.keys.elementAt(index).month;
      String year = scheduleMap.keys.elementAt(index).year;
      // print(date + ' ' + day + ' ' + month + ' ' + year + ' ' + selectedTime);
      await BookingService.editBookingRequest(date, day, month, year, selectedTime, 
      context.read<SelectedDoctor>().id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking request updated. Please wait for the doctor\'s response'))
      );
      setter!();
    } on CustomException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!))
      );
    }
  }

  static Future deleteBookingRequest(BuildContext context, Function? setter) async {
    try {
      await BookingService.deleteBookingRequest(context, context.read<SelectedDoctor>().id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking request cancelled'))
      );
      setter!();
    } on CustomException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!))
      );
    }
  }

  static Stream getBookingRequestList() {
    return BookingService.getBookingRequestList();
  }

  static Future acceptBookingRequest(String reqID, String studentID, BuildContext context, Function setter) async {
    try {
      BookingService.acceptBookingRequest(reqID, studentID);
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

  static Future rejectBookingRequest(String reqID, String studentID, BuildContext context, Function setter) async {
    try {
      BookingService.rejectBookingRequest(reqID, studentID);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking request rejected.'))
      );
      setter();
    } on CustomException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!))
      );
      print(e.message);
    }
  }

  static Stream loadTopDoctors() {
    return BookingService.loadTopDoctors();
  }

  static Future getDoctorListForRating() {
    return BookingService.getDoctorListForRating();
  }
}