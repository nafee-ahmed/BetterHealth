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

  static Stream<User?> get stream { 
    return FirebaseAuth.instance.authStateChanges();
  }

  static Future<String> studentSignUp(String email, String password, String name, String matric, String userType) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'matric': matric,
        'email': email,
        'userType': userType,
      });
      return 'success';
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message!;
    }
  }

  static Future<String> doctorSignUp(String email, String password, String name, String userType) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'email': email,
        'userType': userType,
      });
      return 'success';
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message!;
    }
    
  }

  static Future<String> signIn(String email, String password) async {
    if(email.isEmpty || password.isEmpty) return 'Either email or password field is empty';
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return 'Wrong password or email';
    }
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
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  static Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }
}