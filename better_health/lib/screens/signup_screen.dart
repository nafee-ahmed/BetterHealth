import 'package:better_health/routes.dart';
import 'package:better_health/screens/student_home_screen.dart';
import 'package:better_health/services/user/my_user.dart';
import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/view_model/auth_view_model.dart';
import 'package:better_health/widgets/auth_button.dart';
import 'package:better_health/widgets/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({ Key? key }) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController matricController = TextEditingController();

  

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    matricController.dispose();
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
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/signup_image.png', height: size.height*0.25,)
                ),
                addSpaceVertically(15),
                Text(
                  'Sign up',
                  style: themeData.textTheme.headline1,
                ),
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Input(placeholder: 'Email ID', iconData: Icons.alternate_email, validator: emailValidator, controller: emailController,),
                        Input(placeholder: 'Password', iconData: Icons.lock_outlined, validator: passwordValidator, obscureText: true, controller: passwordController,),
                        Input(placeholder: 'Name', iconData: Icons.perm_identity, validator: nameValidator, controller: nameController,),
                        Input(placeholder: 'Matric', iconData: Icons.fingerprint, validator: matricValidator, controller: matricController,),
                        addSpaceVertically(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already a member?', style: themeData.textTheme.bodyText2,),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).popAndPushNamed(Routes.loginPage);
                              },
                              child: Text(" Login", style: TextStyle(color: COLOR_PRIMARY))
                            ),
                          ],
                        ),
                        AuthButton(size: size, text: 'Student Sign up', pressFunc: () => AuthViewModel.studentSignupPress(context, emailController, passwordController, nameController, matricController, formKey),),
                        AuthButton(size: size, text: 'Doctor Sign up', pressFunc: () => AuthViewModel.doctorSignupPress(context, emailController, passwordController, nameController, formKey), color: COLOR_BLUE,),
                      ],
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

