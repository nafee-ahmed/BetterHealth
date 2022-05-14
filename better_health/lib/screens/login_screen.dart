import 'package:better_health/routes.dart';
import 'package:better_health/services/user/my_user.dart';
import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/view_model/auth_view_model.dart';
import 'package:better_health/widgets/auth_button.dart';
import 'package:better_health/widgets/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);   // gets themeData from main.dart
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center, 
                  child: Image.asset('assets/images/login_image.png', height: size.height*0.35,)
                ),
                addSpaceVertically(35),
                Text(
                  'Login',
                  style: themeData.textTheme.headline1,
                ),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Input(placeholder: 'Email ID', iconData: Icons.alternate_email, validator: emailValidator, controller: emailController,),
                        Input(placeholder: 'Password', iconData: Icons.lock_outlined, validator: passwordValidator, controller: passwordController, obscureText: true,),
                        addSpaceVertically(size.height*0.03),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(Routes.forgotPasswordPage),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?', 
                              style: TextStyle(
                                color: COLOR_PRIMARY
                              ),
                            ),
                          ),
                        ),
                        AuthButton(size: size, text: 'Login', pressFunc: () => AuthViewModel.loginPress(context, emailController, passwordController),),
                        addSpaceVertically(size.height*0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('New to BetterHealth?', style: themeData.textTheme.bodyText2,),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).popAndPushNamed(Routes.signupPage);
                              },
                              child: Text(" Sign Up", style: TextStyle(color: COLOR_PRIMARY))
                            ),
                          ],
                        ),
                        
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




