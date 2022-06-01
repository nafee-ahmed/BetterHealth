import 'package:better_health/screens/schedule_screen.dart';
import 'package:better_health/services/services.dart';
import 'package:better_health/utils/constants.dart';
import 'package:flutter/material.dart';

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
}