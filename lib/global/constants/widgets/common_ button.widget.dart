
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:neethusacademy/global/constants/styles/text_styles.dart';
import 'package:neethusacademy/global/constants/ui/ui_constants.dart';

class CommonButtonWidget extends StatelessWidget {
  const CommonButtonWidget({super.key,required this.onPressed,required this.text,required this.color,required this.isLoading,required this.icon});
  final Function()onPressed;
  final String text;
  final Color color;
  final bool isLoading;
  final bool icon;
  
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
          onPressed: onPressed, child:
           Center(child: isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UIConstants().buttonlLoader()) :
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KStyles().med17(text:text,color: Colors.white ),
                icon == true ? Icon(Icons.arrow_forward,color: kWhite,) : SizedBox()
              ],
            ))
        ),
      ),
    );
  }
}