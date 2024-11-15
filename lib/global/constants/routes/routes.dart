import 'package:flutter/material.dart';
import 'package:neethusacademy/modules/course/view/course_screen.view.dart';
import 'package:neethusacademy/modules/login/view/login_screen.view.dart';
import 'package:neethusacademy/modules/login/view/otp_screen.view.dart';
import 'package:neethusacademy/modules/splash/view/splash_screen.view.dart';

Map<String, Widget Function(BuildContext)> routes = {
    '/' : (BuildContext context) => const SplashScreenView(),
    'login'  : (BuildContext context) => const LoginScreen(),
    'otp' : (BuildContext context) => const OtpScreenView(),
    'course' : (BuildContext context) => const CourseScreenView(),
    
    };