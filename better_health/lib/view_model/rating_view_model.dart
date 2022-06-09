import 'package:better_health/models/rating.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/utils/custom_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class RatingViewModel {
  static Future addRating(double rating, String doctorID, String date, String month, BuildContext context) async {
    late BuildContext dialogContext;
    showDialog(
      context: context, 
      builder: (context) {
        dialogContext = context;
        return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
      }
    );

    try {
      await RatingService.addRating(context.read<Rating>().rating, doctorID, date, month);
      Navigator.of(dialogContext).pop();
      ScaffoldMessenger.of(dialogContext).showSnackBar(
        SnackBar(content: Text('Rated 🥳!'))
      );
    } on CustomException catch (e) {
      Navigator.of(context).pop();
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!))
      );
    }
  }
}