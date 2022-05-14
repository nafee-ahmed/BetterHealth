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
  }) : super(key: key);

  final Size size;
  final ThemeData themeData;
  final String page;
  final Function? executeOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Material(
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
            height: 90,
            padding: EdgeInsets.all(10),
            
            child: Row(
              children: [
                Image.asset('assets/images/doctor_image.png'),
                addSpaceHorizontally(13),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      ignoreGestures: page == 'topDoctors' ? true : false,
                      itemSize: 20,
                      itemBuilder: (context, _) => Icon(Icons.star, color: COLOR_AMBER,),
                      onRatingUpdate: (rating){
                      },
                    ),
                    addSpaceVertically(4),
                    Text('Dr. Angela Hopkins', style: themeData.textTheme.headline5,),
                    Text('Dentist',)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}