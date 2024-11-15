
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:neethusacademy/global/constants/styles/text_styles.dart';

class CommonButtonWidget extends StatelessWidget {
  const CommonButtonWidget({super.key,required this.onPressed,required this.text,required this.color});
  final Function()onPressed;
  final String text;
  final Color color;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 0.w),
      child: SizedBox(
      
        height: 40.h,
        child: ElevatedButton(style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r))
        ),
          onPressed: onPressed, child: Center(child: KStyles().med18(text:text,color: kWhite ))
        ),
      ),
    );
  }
}