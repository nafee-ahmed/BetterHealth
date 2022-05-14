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

