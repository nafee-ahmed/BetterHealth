import 'package:better_health/models/currentUser.dart';
import 'package:better_health/utils/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyUser{
  final String name;
  String? matric;
  final String email;
  String? userType;

  MyUser({
    required this.name, 
    this.matric='', 
    required this.email, 
    this.userType=''});

  static Stream<dynamic> get stream { 
    return FirebaseAuth.instance.authStateChanges();
  }

  static Future<String> studentSignUp(String email, String password, String name, String matric, String speciality, String about, String userType) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
        'name': name,
        'matric': matric,
        'email': email,
        'speciality': speciality,
        'about': about,
        'userType': userType,
      });
      // await FirebaseFirestore.instance.collection('users').add({
      //   'name': name,
      //   'matric': matric,
      //   'email': email,
      //   'userType': userType,
      // });
      return 'success';
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message!;
    }
  }

  static Future<String> doctorSignUp(String email, String password, String name,
  String speciality, String about, String userType) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
        'name': name,
        'email': email,
        'userType': userType,
        'speciality': speciality,
        'about': about,
        'rating': 0
      });
      return 'success';
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message!;
    }
    
  }

  // static Future<String> signIn(String email, String password) async {
  //   if(email.isEmpty || password.isEmpty) return 'Either email or password field is empty';
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  //     return 'success';
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     return 'Wrong password or email';
  //   }
  // }

  static Future signIn(String email, String password) async {
    if(email.isEmpty || password.isEmpty) throw CustomException('Either email or password field is empty');
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw CustomException('Wrong password or email');
    }
  }

  static Future<String> getUserType() async {
    final user = await FirebaseAuth.instance.currentUser;
    if(user != null){
      final users = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get();
      for(var user in users.docs){
        final authUser = user.data();
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
       // notification setup
      await FirebaseMessaging.instance.deleteToken();

      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Future<MyUser> getCurrentUserInfo() async {
    try {
      String name = 'undefined';
      final user = await FirebaseAuth.instance.currentUser;
      String email = user!.email!;
      final users = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      var doc = users.data() as Map<String, dynamic>;
      print('getCurrentUserInfo: ' + doc['name']);
      return MyUser(name: doc['name'], email: email);
    } on FirebaseAuthException catch (e) {
      print(e);
      throw CustomException(e.toString());
    }
  }

  static Future<bool> validatePassword(String password) async {
    final user = await FirebaseAuth.instance.currentUser;
    final authCred = await EmailAuthProvider.credential(email: user!.email!, password: password);
    final authRes = await user.reauthenticateWithCredential(authCred);
    return authRes.user != null;
  }

  static Future<bool> isDuplicateEmailFirestore(String email) async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
    if(query.docs.isNotEmpty) return true;
    else return false;
  }

  static Future<MyUser> editProfile(String name, String oldPassword, String newPassword, String email) async {
    final user = await FirebaseAuth.instance.currentUser;

    try {
      if(await MyUser.validatePassword(oldPassword)){
        await user!.updateEmail(email);
        if(newPassword != ''){
          await user.updatePassword(newPassword);
        }
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'name': name,
          'email': email
        });
        return MyUser(name: name, email: email);
      } else {
        throw CustomException('Current password has to be correct');
      }
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Future<bool> deleteProfile(String oldPassword) async {
    final user = await FirebaseAuth.instance.currentUser;
    
    try {
      if(await MyUser.validatePassword(oldPassword)) {
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).delete();
        await user.delete();
        return true;
      }
      throw CustomException('Current password has to be correct');
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Future<Map<String, dynamic>> getUserDetails() async {
    final user = await FirebaseAuth.instance.currentUser;
    if(user != null){
      final users = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get();
      for(var user in users.docs){
        final authUser = user.data();
        return {'type': authUser['userType'], 'name': authUser['name'], 'email': authUser['email']};
      }
    }
    return {'type': 'not found'};
  }
}