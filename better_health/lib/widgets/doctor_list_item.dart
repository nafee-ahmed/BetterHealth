import 'package:better_health/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../utils/common_functions.dart';
import '../utils/constants.dart';

class DoctorListItem extends StatefulWidget {
  const DoctorListItem({
    Key? key,
    required this.size,
    required this.themeData,
    this.page = 'topDoctors',
    this.executeOnTap,
    this.name = '',
    this.speciality = '',
    this.rating = 0.0
  }) : super(key: key);

  final Size size;
  final ThemeData themeData;
  final String page;
  final Function? executeOnTap;

  final String name;
  final String speciality;
  final double rating;

  @override
  State<DoctorListItem> createState() => _DoctorListItemState();
}

class _DoctorListItemState extends State<DoctorListItem> {
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
            if(widget.executeOnTap != null) widget.executeOnTap!();
          },
          child: Container(
            width: widget.size.width,
            height: widget.page == 'ratingScreen'  ? 105 : 90,
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
                        initialRating: widget.rating,
                        ignoreGestures: widget.page == 'topDoctors' ? true : false,
                        itemSize: 20,
                        itemBuilder: (context, _) => Icon(Icons.star, color: COLOR_AMBER,),
                        onRatingUpdate: (rating){
                          context.read<Rating>().rating = rating;
                          if (widget.executeOnTap != null && widget.page == 'ratingScreen') widget.executeOnTap!();
                        },
                      ),
                      addSpaceVertically(4),
                      Text(
                        widget.name == '' ? 'Sample Data' : widget.name, 
                        style: widget.themeData.textTheme.headline5,
                      ),
                      widget.page == 'ratingScreen' 
                      ? Text(
                        widget.speciality == '' ? 'Sample' : widget.speciality,
                        style: widget.themeData.textTheme.subtitle1,
                      )
                      : Text(
                        widget.speciality == '' ? 'Sample' : widget.speciality,
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