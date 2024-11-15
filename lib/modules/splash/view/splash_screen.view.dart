
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:neethusacademy/global/constants/images/images.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
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
    Future.delayed(const Duration(seconds: 8),(){
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
    return  Scaffold(backgroundColor:kBlack,
    body: Column(crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset(logo,)),
        Gap(5.h),
      
     
      
      ],
    ),
    );
  }
}