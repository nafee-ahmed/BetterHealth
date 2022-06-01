import 'package:flutter/material.dart';

class SelectedDoctor with ChangeNotifier{
  String _name = '';
  String _speciality = '';
  double _rating = 0;
  String _about = '';
  String _id = '';

  String get name => _name;
  String get speciality => _speciality;
  double get rating => _rating;
  String get about => _about;
  String get id => _id;

  set name(String name){
    _name = name;
    notifyListeners();
  }

  set speciality(String speciality) {
    _speciality = speciality;
    notifyListeners();
  }

  set rating(double rating) {
    _rating = rating;
    notifyListeners();
  }

  set about(String about) {
    _about = about;
    notifyListeners();
  }

  set id(String id) {
    _id = id;
    notifyListeners();
  }
}