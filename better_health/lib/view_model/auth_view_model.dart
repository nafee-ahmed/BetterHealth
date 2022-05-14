import 'package:better_health/routes.dart';
import 'package:better_health/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/user/my_user.dart';

class AuthViewModel{
  static Future loginPress(BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {
    try {
      showDialog(
        context: context, 
        builder: (context){
          return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
        }
      );
      await MyUser.signIn(emailController.text.trim(), passwordController.text.trim());
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(Routes.authPage);
      // Navigator.of(context).pushNamedAndRemoveUntil(Routes.authPage, (route) => false);
    } on FirebaseAuthException catch (e) {
      print(e);
      var msg = 'Wrong password or email';
      if(emailController.text.isEmpty || passwordController.text.isEmpty){
         msg = 'Either email or password field is empty';
      }
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg))
      );
    }
    
    return null;
  }

  static Future? doctorSignupPress(BuildContext context, TextEditingController emailController, TextEditingController passwordController,
    TextEditingController nameController, final formKey) async {
    if(formKey.currentState!.validate()){
      try {
        showDialog(
          context: context, 
          builder: (context){
            return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
          }
        );
        await MyUser.doctorSignUp(emailController.text.trim(), passwordController.text.trim(), nameController.text.trim(), 'doctor');
        Navigator.of(context).pop();
        Navigator.of(context).popAndPushNamed(Routes.doctorHomePage);
      } on FirebaseAuthException catch (e) {
        print(e);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString()))
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
      try {
        showDialog(
          context: context, 
          builder: (context){
            return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
          }
        );
        await MyUser.studentSignUp(emailController.text.trim(), passwordController.text.trim(), nameController.text.trim(), matricController.text.trim(), 'student');
        Navigator.of(context).pop();  // loading bar
        print('Sign up values: ${emailController.text}, ${passwordController.text}, ${nameController.text}, ${matricController.text}');
        Navigator.of(context).popAndPushNamed(Routes.studentHome);
      } on FirebaseAuthException catch (e) {
        print(e);
        Navigator.of(context).pop();  // loading bar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString()))
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
    try {
      await MyUser.logout();
      // Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(Routes.authPage);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  static Future? forgotPasswordPress(BuildContext context, TextEditingController emailController) async {
    try {
      await MyUser.forgotPassword(emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset link sent to your email!'))
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString()))
      );
    }
  }
}