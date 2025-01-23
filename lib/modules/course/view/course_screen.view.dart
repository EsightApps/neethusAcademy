import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:neethusacademy/global/constants/images/images.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:neethusacademy/global/constants/styles/text_styles.dart';
import 'package:neethusacademy/modules/splash/controller/splash_controller.dart';
import 'package:neethusacademy/modules/course/widget/alertbox.widget.dart';
import 'package:neethusacademy/modules/course/widget/single_course.widget.dart';
import 'package:provider/provider.dart';
import '../../../global/config/databox.dart';
import '../../../global/constants/location/location_service.dart';
import '../../home/view/home_screen.view.dart';

class CourseScreenView extends StatefulWidget {
  const CourseScreenView({super.key});

  @override
  State<CourseScreenView> createState() => _CourseScreenViewState();
}

class _CourseScreenViewState extends State<CourseScreenView> {
  @override
  void initState() {
    super.initState();
    LocationService().checkLocationServiceAndPermission();
    
   
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
            centerTitle: true,
            backgroundColor: kBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child:
                  Consumer<SplashController>(builder: (context, spalshCtrl, _) {
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
