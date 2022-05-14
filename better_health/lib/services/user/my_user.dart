import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyUser{
  final String id;
  final String name;
  String matric;
  final String email;
  final String userType;
  MyUser({
    required this.id, 
    required this.name, 
    this.matric='', 
    required this.email, 
    required this.userType});

  static Future studentSignUp(String email, String password, String name, String matric, String userType) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'matric': matric,
      'email': email,
      'userType': userType,
    });
  }

  static Future doctorSignUp(String email, String password, String name, String userType) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'email': email,
      'userType': userType,
    });
  }

  static Future signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<String> getUserType() async {
    final user = await FirebaseAuth.instance.currentUser;
    if(user != null){
      final users = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get();
      for(var user in users.docs){
        final authUser = user.data();
        print(authUser['userType']);
        return authUser['userType'];
      }
    }
    return 'not found';
  }

  static Future forgotPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}