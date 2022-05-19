import 'package:better_health/routes.dart';
import 'package:better_health/services/user/my_user.dart';
import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/view_model/auth_view_model.dart';
import 'package:better_health/widgets/auth_button.dart';
import 'package:better_health/widgets/input.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({ Key? key }) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  void onLeftPress(){
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);   // gets themeData from main.dart
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_WHITE,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onLeftPress,
                  child: FaIcon(FontAwesomeIcons.arrowLeft),
                ),
                Align(
                  alignment: Alignment.center, 
                  child: Image.asset('assets/images/forgot_password_image.jpeg', height: size.height*0.40,)
                ),
                addSpaceVertically(35),
                Text(
                  'Forgot Password',
                  style: themeData.textTheme.headline1,
                ),
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Input(placeholder: 'Email ID', iconData: Icons.alternate_email, validator: emailValidator, controller: emailController,),
                        addSpaceVertically(size.height*0.03),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Enter your email and we will send a password reset link', 
                          ),
                        ),
                        AuthButton(size: size, text: 'Reset Password', pressFunc: () => AuthViewModel.forgotPasswordPress(context, emailController),),
                        addSpaceVertically(size.height*0.03),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}