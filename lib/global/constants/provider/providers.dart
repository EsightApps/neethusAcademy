
import 'package:neethusacademy/modules/splash/controller/splash_controller.dart';
import 'package:neethusacademy/modules/login/controller/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
List<SingleChildWidget> providerList = [
  ChangeNotifierProvider(create: (context) => LoginController()),
   ChangeNotifierProvider(create: (context) => SplashController()),
 
 
   
  ];