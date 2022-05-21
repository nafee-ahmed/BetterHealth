import 'package:better_health/routes.dart';
import 'package:better_health/utils/constants.dart';
import 'package:flutter/material.dart';

import '../services/services.dart';

class AuthViewModel{
  static Future loginPress(BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {
    showDialog(
      context: context, 
      builder: (context){
        return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
      }
    );
    String signedInOrNot = await MyUser.signIn(emailController.text.trim(), passwordController.text.trim());

    if(signedInOrNot == 'success'){
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(Routes.authPage);
    }
    else{
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(signedInOrNot))
      );
    }
    return null;
  }

  static Future? doctorSignupPress(BuildContext context, TextEditingController emailController, TextEditingController passwordController,
    TextEditingController nameController, final formKey) async {
    if(formKey.currentState!.validate()){
      showDialog(
        context: context, 
        builder: (context){
          return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
        }
      );
      String signedUpOrNot = await MyUser.doctorSignUp(emailController.text.trim(), passwordController.text.trim(), nameController.text.trim(), 'doctor');
      if(signedUpOrNot == 'success') {
        Navigator.of(context).pop();
        Navigator.of(context).popAndPushNamed(Routes.doctorHomePage);
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(signedUpOrNot))
        );
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please validate'))
      );
    }
    return null;
  }

  static Future studentSignupPress(BuildContext context, TextEditingController emailController, TextEditingController passwordController, 
    TextEditingController nameController, TextEditingController matricController, final formKey) async {
    if(formKey.currentState!.validate()){
      showDialog(
        context: context, 
        builder: (context){
          return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
        }
      );
      String signedUpOrNot = await MyUser.studentSignUp(emailController.text.trim(), passwordController.text.trim(), nameController.text.trim(), matricController.text.trim(), 'student');

      if (signedUpOrNot == 'success') {
        Navigator.of(context).pop();  // loading bar
        // print('Sign up values: ${emailController.text}, ${passwordController.text}, ${nameController.text}, ${matricController.text}');
        Navigator.of(context).popAndPushNamed(Routes.studentHome);
      } else {
        Navigator.of(context).pop();  // loading bar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(signedUpOrNot))
        );
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please validate'))
      );
    }
    return null;
  }

  static Future? logoutPress(BuildContext context) async {
    String loggedOutOrNot = await MyUser.logout();
    if(loggedOutOrNot == 'success') {
      // Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(Routes.authPage);
    } else {
      print(loggedOutOrNot);
    }
  }

  static Future? forgotPasswordPress(BuildContext context, TextEditingController emailController) async {
    String forgotRes = await MyUser.forgotPassword(emailController.text.trim());
    if(forgotRes == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset link sent to your email!'))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(forgotRes))
      );
    }
  }
}