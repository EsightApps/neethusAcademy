import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../ui/ui_constants.dart';


class CommonButtonWidget extends StatelessWidget {
  const CommonButtonWidget(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.color,
      required this.isLoading,
      this.height,
      this.borderRadius,
      required this.icon});
  final Function() onPressed;
  final String text;
  final Color color;
  final bool isLoading;
  final bool icon;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: SizedBox(
        height: height ?? 40.h,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 5.r))),
            onPressed: onPressed,
            child: Center(
                child: isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UIConstants().buttonlLoader())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          KStyles().med17(text: text, color: Colors.white),
                          icon == true
                              ? Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: kWhite,
                                    size: 20.sp,
                                  ),
                                )
                              : SizedBox()
                        ],
                      ))),
      ),
    );
  }
}
