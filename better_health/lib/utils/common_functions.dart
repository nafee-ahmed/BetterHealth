import 'package:better_health/utils/constants.dart';
import 'package:flutter/material.dart';

Widget addSpaceVertically(double height){
  return SizedBox(
    height: height,
  );
}

Widget addSpaceHorizontally(double width){
  return SizedBox(
    width: width,
  );
}

Future<dynamic> Loader(BuildContext context) {
  return showDialog(
    context: context, 
    builder: (context){
      return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
    }
  );
}


String getDay(String longDay) {
  if (longDay == 'Sunday') return 'Su';
  else if (longDay == 'Monday') return 'Mon';
  else if (longDay == 'Tuesday') return 'Tu';
  else if (longDay == 'Wednesday') return 'We';
  else if (longDay == 'Thursday') return 'Th';
  else if (longDay == 'Friday') return 'Fri';
  else if (longDay == 'Saturday') return 'Sat';
  else return 'No';
}

String getMonth(String longMonth) {
  if (longMonth == 'January') return 'Jan';
  else if (longMonth == "February") return 'Feb';
  else if (longMonth == "March") return 'Mar';
  else if (longMonth == "April") return 'Apr';
  else if (longMonth == "May") return 'May';
  else if (longMonth == "Jun") return 'Jun';
  else if (longMonth == "Jul") return 'Jul';
  else if (longMonth == "August") return 'Aug';
  else if (longMonth == "September") return 'Sep';
  else if (longMonth == "October") return 'Oct';
  else if (longMonth == "November") return 'Nov';
  else if (longMonth == "December") return 'Dec';
  else return 'No';
}


String? emailValidator(String? value){
  if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,7}').hasMatch(value)){
    return 'Enter correct email format';
  }
  else{
    return null;
  }
}

String? passwordValidator(String? value){
  if(value!.isEmpty){
    return 'Enter correct password format';
  }
  else if(value.length < 6){
    return 'has to be more than 6 characters';
  }
  else{
    return null;
  }
}

String? updatePasswordValidator(String? value){
  if(!value!.isEmpty && value.length < 6){
    return 'has to be more than 6 characters';
  } else {
    return null;
  }
}

String? nameValidator(String? value){
  if(value!.isEmpty){
    return 'Enter correct name format';
  }
  else{
    return null;
  }
}

String? matricValidator(String? value){
  if(value!.isEmpty){
    return 'Enter correct matric format';
  }
  else{
    return null;
  }
}

String? emergencyValidator(String? value){
  if(value!.isEmpty){
    return 'This is required';
  }
  else{
    return null;
  }
}

String? aboutValidator(String? value){
  if(value!.isEmpty){
    return 'This is required';
  }
  else{
    return null;
  }
}

String? specialityValidator(String? value){
  if(value!.isEmpty){
    return 'This is required';
  }
  else{
    return null;
  }
}

