
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neethusacademy/global/constants/images/images.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:neethusacademy/modules/splash/controller/splash_controller.dart';
import 'package:provider/provider.dart';
import '../../../global/config/databox.dart';
import '../../../global/config/db_key.dart';
import '../../home/view/home_screen.view.dart';



class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState(){
    super.initState();
    var splashCtrl = Provider.of<SplashController>(context, listen: false);
   splashCtrl.getWebLink();
    Future.delayed(const Duration(seconds: 5),(){
      String ? token = userSavedBox.get(DbKey().userSaved);
      String ? course = userSavedBox.get('course');
  
       token != null && token.isNotEmpty ?
       course !=null && course.isNotEmpty  ?
        Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  HomeScreen(url:splashCtrl.webLink),
                              ),(routes){
                                return false;
                              }
                            
                            ) :

    Navigator.pushNamedAndRemoveUntil(context, 'course', (routes){
        return false;
      }) :
       Navigator.pushNamedAndRemoveUntil(context, 'login', (routes){
        return false;
      });
      
   } );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor:kBlue,
    body: Column(crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Center(child: Image.asset(logo,width: 300.w,)),
      
       
     
      
      ],
    ),
    );
  }
}