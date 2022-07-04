import 'package:flutter/material.dart';

class SelectedEmergency with ChangeNotifier{
  String _name = '';
  String _text = '';
  String _id = '';
  double _latitude = 0;
  double _longitude = 0;


  String get name => _name;
  String get text => _text;
  String get id => _id;
  double get latitude => _latitude;
  double get longitude => _longitude;

  set name(String name){
    _name = name;
    notifyListeners();
  }

  set text(String text){
    _text = text;
    notifyListeners();
  }

  set id(String id){
    _id = id;
    notifyListeners();
  }

  set latitude(double latitude){
    _latitude = latitude;
    notifyListeners();
  }

  set longitude(double longitude){
    _longitude = longitude;
    notifyListeners();
  }
}