
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:neethusacademy/global/constants/images/images.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:neethusacademy/global/constants/styles/text_styles.dart';
import 'package:neethusacademy/modules/course/controller/course_controller.dart';
import 'package:neethusacademy/modules/course/widget/alertbox.widget.dart';
import 'package:neethusacademy/modules/course/widget/single_course.widget.dart';
import 'package:provider/provider.dart';
import '../../../global/constants/location/location_service.dart';
import '../../home/view/home_screen.view.dart';

class CourseScreenView extends StatefulWidget {
  const CourseScreenView({super.key});

  @override
  State<CourseScreenView> createState() => _CourseScreenViewState();
}

class _CourseScreenViewState extends State<CourseScreenView> {
  @override
  void initState(){
    super.initState();
     LocationService().requestLocationAndFetchDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CourseController>(
      builder: (context, courseCtrl, _) {
        return WillPopScope(
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
            return exitApp ; 
          },
          child: Scaffold(
            backgroundColor: kLightBlue,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.h),
              child: AppBar(title: KStyles().med19(text: 'Courses',color: Colors.white),
              centerTitle: true,
                backgroundColor: kBlue,
                leadingWidth: 70.w,
                leading: Padding(
                  padding:  EdgeInsets.only(left: 10.w),
                  child: Image.asset(logo),
                )
               ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.r),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20.h),
                    Row(
                      children: [
                        KStyles().semiBold17(text: 'Choose Your ',color: kBlue),
                        Image.asset(course,width:22.w,height: 22.h,),
                         KStyles().semiBold17(text: ' Course',color: kBlue),
                      ],
                    ),
                
                    Gap(20.h),
                    GridView.builder(
                      itemCount: courseCtrl.courses.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 3,
                      ),
                      itemBuilder: (BuildContext context, index) {
                        return CourseWidgetCard(
                          colors: courseCtrl.courseColors[index],
                          onPressed: () {
                            courseCtrl.setSelectedUrl(courseCtrl.courseUrls[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          courseImage: courseCtrl.courseImages[index],
                          courseName: courseCtrl.courses[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
