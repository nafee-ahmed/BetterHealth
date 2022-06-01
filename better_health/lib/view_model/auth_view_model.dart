import 'package:better_health/models/currentUser.dart';
import 'package:better_health/routes.dart';
import 'package:better_health/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import '../utils/custom_exception.dart';

class AuthViewModel{
  // static Future loginPress(BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {
  //   showDialog(
  //     context: context, 
  //     builder: (context){
  //       return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
  //     }
  //   );

  //   try {
  //     String signedInOrNot = await MyUser.signIn(emailController.text.trim(), passwordController.text.trim());
  //     if(signedInOrNot == 'success'){
  //       Navigator.of(context).pop();
  //       Navigator.of(context).pushReplacementNamed(Routes.authPage);
  //     }
  //     else{
  //       Navigator.of(context).pop();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(signedInOrNot))
  //       );
  //     }
  //   } catch (e) {
  //     print(e);
  //     Navigator.of(context).pop();
  //   }
  //   return null;
  // }

  static Future loginPress(BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {
    BuildContext cont = context;
    showDialog(
      context: context, 
      builder: (context){
        return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
      }
    );

    try {
      await MyUser.signIn(emailController.text.trim(), passwordController.text.trim());
      Navigator.of(cont).pop();
      Navigator.of(context).pushReplacementNamed(Routes.authPage);
        
    } on CustomException catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString()))
      );
    }
    return null;
  }

  static Future? doctorSignupPress(BuildContext context, TextEditingController emailController, TextEditingController passwordController,
    TextEditingController nameController, TextEditingController specialityController, TextEditingController aboutController, final formKey) async {
    if(formKey.currentState!.validate()){
      showDialog(
        context: context, 
        builder: (context){
          return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
        }
      );
      String signedUpOrNot = await MyUser.doctorSignUp(emailController.text.trim(), passwordController.text.trim(), nameController.text.trim(),
      specialityController.text.trim(), aboutController.text.trim(), 'doctor');
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
    TextEditingController nameController, TextEditingController matricController, TextEditingController specialityController, 
    TextEditingController aboutController, final formKey) async {
    if(formKey.currentState!.validate()){
      showDialog(
        context: context, 
        builder: (context){
          return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
        }
      );
      String signedUpOrNot = await MyUser.studentSignUp(emailController.text.trim(), passwordController.text.trim(), nameController.text.trim(), matricController.text.trim(),
      specialityController.text.trim(), aboutController.text.trim(), 'student');
      // context.read<CurrentUser>().name = nameController.text.trim();


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
    try {
      await MyUser.logout();
      Navigator.of(context).pushReplacementNamed(Routes.authPage);
    } on CustomException catch (e) {
      print(e.message);
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

  static Future<MyUser> getStudentCurrentUser(BuildContext context) async {
    try {
      final cont =  context.read<CurrentUser>();
      MyUser currentUser = await MyUser.getCurrentUserInfo();
      print(currentUser.name);
      cont.name = currentUser.name;
      cont.email = currentUser.email;
      return MyUser(name: currentUser.name, email: currentUser.email);
    } on CustomException catch (e) {
      print(e);
      throw CustomException(e.message);
    }
  }

  static Future<String> getDoctorCurrentUser(BuildContext context) async {
    try {
      MyUser currentUser = await MyUser.getCurrentUserInfo();
      context.read<CurrentUser>().name = currentUser.name;
      context.read<CurrentUser>().email = currentUser.email;
    } catch (e) {
      print(e);
    }
    return 'not found';
  }

  static Future? editProfile(String name, String oldPassword, String newPassword, String email, 
  final formKey, BuildContext context) async {
      if(formKey.currentState!.validate()) {
        showDialog(
          context: context, 
          builder: (context){
            return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
          }
        );
        try {
          MyUser userRes = await MyUser.editProfile(name, oldPassword, newPassword, email);
          await MyUser.logout();
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(Routes.authPage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated. Please login again.'))
          );
        } on CustomException catch (e) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message!))
          );
        }
      }
      return null;
    }

    static Future? deleteProfile(String oldPassword, BuildContext context) async {
      showDialog(
        context: context, 
        builder: (context){
          return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
        }
      );
      try {
        if(oldPassword.isEmpty) throw CustomException('Please enter curent password');
        bool userRes = await MyUser.deleteProfile(oldPassword);
        // await MyUser.logout();
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(Routes.authPage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sad to see you go! All your user data has been deleted.'))
        );
      } on CustomException catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!))
        );
      }
      return null;
    }

    // static Future? editDoctorProfile(String name, String oldPassword, String newPassword, String email,
    // final formKey, BuildContext context) async {
    //   if(formKey.currentState!.validate()) {
    //     showDialog(
    //       context: context, 
    //       builder: (context){
    //         return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
    //       }
    //     );
    //     try {
    //       MyUser userRes = await MyUser.editProfile(name, oldPassword, newPassword, email);
    //       await MyUser.logout();
    //       Navigator.of(context).pop();
    //       Navigator.of(context).pushReplacementNamed(Routes.authPage);
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Profile updated. Please login again.'))
    //       );
    //     } on CustomException catch (e) {
    //       Navigator.of(context).pop();
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text(e.message!))
    //       );
    //     }
    //   }
    //   return null;
    // }

    // static Future? deleteDoctorProfile(String oldPassword, BuildContext context) async {
    //   showDialog(
    //     context: context, 
    //     builder: (context){
    //       return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
    //     }
    //   );
    //   try {
    //     if(oldPassword.isEmpty) throw CustomException('Please enter curent password');
    //     bool userRes = await MyUser.deleteProfile(oldPassword);
    //     // await MyUser.logout();
    //     Navigator.of(context).pop();
    //     Navigator.of(context).pushReplacementNamed(Routes.authPage);
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Sad to see you go! All you user data has been deleted.'))
    //     );
    //   } on CustomException catch (e) {
    //     Navigator.of(context).pop();
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text(e.message!))
    //     );
    //   }
    //   return null;
    // }

}