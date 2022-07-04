import 'package:better_health/screens/auth_screen.dart';
import 'package:better_health/screens/doctor_home_screen.dart';
import 'package:better_health/screens/doctor_profile_screen.dart';
import 'package:better_health/screens/doctor_request.dart';
import 'package:better_health/screens/emergency_request_screen.dart';
import 'package:better_health/screens/forgot_password_screen.dart';
import 'package:better_health/screens/loading_screen.dart';
import 'package:better_health/screens/login_screen.dart';
import 'package:better_health/screens/notification_screen.dart';
import 'package:better_health/screens/signup_screen.dart';
import 'package:better_health/screens/student_home_screen.dart';
import 'package:better_health/screens/student_profile_screen.dart';
import 'package:better_health/screens/student_rating_screen.dart';
import 'package:better_health/screens/view_emergency.dart';
import 'package:better_health/screens/view_emergency_details.dart';
import 'package:flutter/material.dart';

class Routes{
  static const String loginPage = '/';
  static const String signupPage = '/signup';
  static const String studentHome = '/student/home';
  static const String emergencyRequestPage = '/emergency/request';
  static const String studentProfilePage = '/student/profile';
  static const String studentRatingPage = '/student/rating';
  static const String doctorRequestPage = '/doctor/request';

  static const String notificationPage = '/notifications';
  static const String forgotPasswordPage = '/forgotpassword';

  static const String doctorHomePage = '/doctor/home';
  static const String doctorProfilePage = '/doctor/profile';
  static const String doctorViewEmergency = '/doctor/emergency';

  static const String doctorViewEmergencyDetails = '/doctor/emergencydetails';


  static const String authPage = '/auth';

  static const String loadingPage = '/loading';


  static Route<dynamic> generateRoutes(RouteSettings settings){
    switch(settings.name){
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case signupPage:
        return MaterialPageRoute(
          builder: (context) => SignupScreen(),
        );
      case studentHome:
        return MaterialPageRoute(
          builder: (context) => StudentHomeScreen(),
        );
      case emergencyRequestPage:
        return MaterialPageRoute(
          builder: (context) => EmergencyRequestScreen(),
        );
      case studentRatingPage:
        return MaterialPageRoute(
          builder: (context) => StudentRateScreen(),
        );
      case studentProfilePage:
        return MaterialPageRoute(
          builder: (context) => StudentProfileScreen(),
        );
      case doctorRequestPage:
        return MaterialPageRoute(
          builder: (context) => DoctorRequest(),
        );
      case doctorHomePage:
        return MaterialPageRoute(
          builder: (context) => DoctorHomeScreen(),
        );
      case doctorProfilePage:
        return MaterialPageRoute(
          builder: (context) => DoctorProfileScreen(),
        );
      case doctorViewEmergency:
        return MaterialPageRoute(
          builder: (context) => ViewEmergency(),
        );
      case notificationPage:
        return MaterialPageRoute(
          builder: (context) => NotificationScreen(),
        );
      case authPage:
        return MaterialPageRoute(
          builder: (context) => AuthScreen(),
        );
      case forgotPasswordPage:
        return MaterialPageRoute(
          builder: (context) => ForgotPasswordScreen(),
        );
      case doctorViewEmergencyDetails:
        return MaterialPageRoute(
          builder: (context) => ViewEmergencyDetails(),
        );
      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => LoadingScreen(),
        );
      default:
        throw FormatException('Routes not found');
    }
  }
}