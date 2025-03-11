import 'package:NeethusApp/modules/course/controller/course_controller.dart';
import 'package:NeethusApp/modules/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../global/config/databox.dart';
import '../../../global/constants/images/images.dart';
import '../../../global/constants/styles/colors.dart';
import '../../../global/constants/styles/text_styles.dart';
import '../../home/view/home_screen.view.dart';
import '../../splash/controller/splash_controller.dart';
import '../widget/alertbox.widget.dart';
import '../widget/single_course.widget.dart';

class CourseScreenView extends StatefulWidget {
  const CourseScreenView({super.key});

  @override
  State<CourseScreenView> createState() => _CourseScreenViewState();
}

class _CourseScreenViewState extends State<CourseScreenView> {
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var courseCtrl = Provider.of<CourseController>(context, listen: false);
      courseCtrl.checkLocationServiceAndPermission();
    });
  }

  List courses = ['OET', 'IELTS', 'NCLEX-RN', 'GERMAN', 'CBT', 'OSCE', 'TOEFL'];
  List courseImages = [oet, ielts, nclex, german, cbt, osce, toefl];
  @override
  Widget build(BuildContext context) {
    return WillPopScope.new(
        onWillPop: () async {
          bool exitApp = await showDialog(
            context: context,
            builder: (context) {
              return AlertBoxWidget(
                title: 'Exit App?',
                content: 'Are you sure you want to exit the application?',
                subtitle: 'Exit',
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              );
            },
          );
          return exitApp;
        },
        child: Scaffold(
          backgroundColor: kWhite,
          appBar: AppBar(
            title: Image.asset(logo),
            centerTitle: false,
            backgroundColor: kBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Consumer3<SplashController, CourseController,
                      LoginController>(
                  builder: (context, spalshCtrl, courseCtrl, logCtrl, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20.h),
                    KStyles().semiBold17(text: 'Choose Course ', color: kBlue),
                    Gap(20.h),
                    GridView.builder(
                      itemCount: courses.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 3,
                      ),
                      itemBuilder: (BuildContext context, index) {
                        return CourseWidgetCard(
                          onPressed: () {
                        
                            Future.delayed(const Duration(seconds: 5), () {
                                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
                              courseCtrl.addCourse(logCtrl.userId,
                                  courses[index], courseCtrl.location);
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(url: '${spalshCtrl.webLink}'),
                                ), (routes) {
                              return false;
                            });

                            userSavedBox.put('course', courses[index]);
                          },
                          courseImage: courseImages[index],
                          courseName: courses[index],
                        );
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        ));
  }
}
