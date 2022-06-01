import 'package:flutter/material.dart';

class CurrentUser with ChangeNotifier{
  String _name = '';
  String _matric = '';
  String _email = '';
  String _userType = '';
  String _password = '';

  String get name => _name;
  String get password => _password;
  String get email => _email;

  set name(String name){
    _name = name;
    notifyListeners();
  }

  set password(String password){
    _password = password;
    notifyListeners();
  } 

  set email(String email){
    _email = email;
    notifyListeners();
  } 
}