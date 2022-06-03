import 'package:flutter/material.dart';

class Rating with ChangeNotifier{
  double _rating = 0;

  double get rating => _rating;

  set rating(double rating){
    _rating = rating;
    notifyListeners();
  }
}