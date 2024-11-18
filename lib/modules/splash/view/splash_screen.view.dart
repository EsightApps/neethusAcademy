
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:neethusacademy/global/constants/images/images.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:neethusacademy/global/constants/styles/text_styles.dart';

import '../../../global/config/databox.dart';
import '../../../global/config/db_key.dart';




class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 5),(){
      String ? token = userSavedBox.get(DbKey().userSaved);
  
       token != null && token.isNotEmpty ?
    Navigator.pushNamedAndRemoveUntil(context, 'course', (routes){
        return false;
      }) :
       Navigator.pushNamedAndRemoveUntil(context, 'login', (routes){
        return false;
      });
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor:kBlue,
    body: Column(crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Container(width: 80.w,height: 50.h,color: kWhite,
        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
          child: Image.asset(logo,width: 100.w,))),
       Gap(10.h),
         Center(
          child: KStyles().semiBold20(text: "Neethu's Accademy",color:kWhite),
         )
     
      
      ],
    ),
    );
  }
}