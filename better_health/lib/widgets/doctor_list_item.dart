import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../utils/common_functions.dart';
import '../utils/constants.dart';

class DoctorListItem extends StatelessWidget {
  const DoctorListItem({
    Key? key,
    required this.size,
    required this.themeData,
    this.page = 'topDoctors',
    this.executeOnTap,
    this.name = '',
    this.speciality = '',
    this.rating = 0
  }) : super(key: key);

  final Size size;
  final ThemeData themeData;
  final String page;
  final Function? executeOnTap;

  final String name;
  final String speciality;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Material(        
        elevation: 3,
        shadowColor: COLOR_BOX_GREY.withOpacity(.25),
        color: COLOR_BOX_GREY,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          onTap: (){
            if(executeOnTap != null) executeOnTap!();
          },
          child: Container(
            width: size.width,
            height: page == 'ratingScreen'  ? 105 : 90,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset('assets/images/doctor_image.png'),
                addSpaceHorizontally(13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        initialRating: rating,
                        ignoreGestures: page == 'topDoctors' ? true : false,
                        itemSize: 20,
                        itemBuilder: (context, _) => Icon(Icons.star, color: COLOR_AMBER,),
                        onRatingUpdate: (rating){
                          print('Rating: ' + rating.toString());
                        },
                      ),
                      addSpaceVertically(4),
                      Text(
                        name == '' ? 'Sample Data' : name, 
                        style: themeData.textTheme.headline5,
                      ),
                      page == 'ratingScreen' 
                      ? Text(
                        speciality == '' ? 'Sample' : speciality,
                        style: themeData.textTheme.subtitle1,
                      )
                      : Text(
                        speciality == '' ? 'Sample' : speciality,
                      ),
                    ],
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







// color: Colors.black.withOpacity(0.25),
//                 blurRadius: 30,
//                 offset: Offset(0, 10),