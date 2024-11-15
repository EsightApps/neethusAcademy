import 'package:flutter/cupertino.dart';
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
        decoration: BoxDecoration(border: Border.all(color: kBorderGrey),
          borderRadius: BorderRadius.circular(10.r)),
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
        child: Row(
          children: [
            Image.asset(courseImage,width: 50.w,height: 50.h,),
            Gap(3.w),
            KStyles().light15(text: courseName)
      
          ],
        ),
      ),
    );
  }
}