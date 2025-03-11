

import 'package:NeethusApp/modules/course/controller/course_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../modules/login/controller/login_controller.dart';
import '../../../modules/splash/controller/splash_controller.dart';
List<SingleChildWidget> providerList = [
  ChangeNotifierProvider(create: (context) => LoginController()),
   ChangeNotifierProvider(create: (context) => SplashController()),
   ChangeNotifierProvider(create: (context) => CourseController()),
 
 
   
  ];