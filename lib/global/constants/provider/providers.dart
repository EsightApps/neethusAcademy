import 'package:neethusacademy/modules/course/controller/course_controller.dart';
import 'package:neethusacademy/modules/login/controller/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
List<SingleChildWidget> providerList = [
  ChangeNotifierProvider(create: (context) => LoginController()),
  ChangeNotifierProvider(create: (context) => CourseController()),
   
  ];