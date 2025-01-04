import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:neethusacademy/global/constants/styles/text_styles.dart';

class CourseWidgetCard extends StatelessWidget {
  const CourseWidgetCard({super.key,required this.courseName,required this.courseImage,required this.onPressed});
 final  String courseName;
  final String courseImage;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed ,
      child: Container(height: 30.h,
        decoration: BoxDecoration(color: kWhite,
       
        border: Border.all(color: kBorderGrey,width: 0.4),
          borderRadius: BorderRadius.circular(10.r)),
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 4.h),
        child: Row(
          children: [
            Container(width: 40.w,height: 40.h,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(courseImage),fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(5.r),
              
            ),
              ),
            Gap(6.w),
            KStyles().med15(text: courseName)
      
          ],
        ),
      ),
    );
  }
}