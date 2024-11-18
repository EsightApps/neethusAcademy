import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:neethusacademy/global/constants/images/images.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:neethusacademy/global/constants/styles/text_styles.dart';
import 'package:neethusacademy/global/constants/widgets/common_%20button.widget.dart';
import 'package:neethusacademy/global/constants/widgets/textfield.widget.dart';
import 'package:neethusacademy/modules/login/controller/login_controller.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, loginCtrl, _) {
        return Scaffold(resizeToAvoidBottomInset: false,
          backgroundColor: kLightBlue,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(70.h),
                Center(
                  child: Lottie.asset(
                    login,
                    animate: true,
                    width: 270.w,
                    height: 270.h,
                  ),
                ),
                
                KStyles().semiBold17(text: 'Login to your Account',color: kBlue),
                Gap(20.h),
                PhoneTextField(
                  controller: loginCtrl.phoneCtrl,
                  onChanged: (PhoneNumber number) {
                    // Update phone number and UI state
                    loginCtrl.onPhoneNumberChanges(number);
                    setState(() {
                      
                    });
                   
                  },
                ),
                Gap(7.h),
                KStyles().med13(
                  text: 'Please enter your mobile number to continue.',
                ),
                Gap(50.h),
                // Padding(
                //   padding:  EdgeInsets.symmetric(horizontal: 30.w),
                //   child: CommonButtonWidget(isLoading: loginCtrl.apiLoading,
                //                 onPressed: () async {
                //   if (loginCtrl.phoneCtrl.text.length == 10) {
                //     loginCtrl.setLoginVal(0);
                  
                //     bool success = await loginCtrl.loginApi();
                //     if (success) {
                //       // Navigate to OTP screen if login is successful
                //       Navigator.pushNamed(context, 'otp');
                //     } else {
                //       // Show toast for invalid phone number
                //       Fluttertoast.showToast(
                //         msg: 'Invalid PhoneNumber',
                //         backgroundColor: kBlack,
                //       );
                //     }
                //   }
                //                 },
                //                 text: 'Continue',
                //                 color: loginCtrl.phoneCtrl.text.length == 10
                //     ? kBlue
                //     : const Color.fromARGB(255, 192, 195, 228),
                //               ),
                // ),

              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 30.h, left: 30.w, right: 30.w),
            child: CommonButtonWidget(isLoading: loginCtrl.apiLoading,icon: true,
              onPressed: () async {
                if (loginCtrl.phoneCtrl.text.length == 10) {
                  loginCtrl.setLoginVal(0);

                  bool success = await loginCtrl.loginApi();
                  if (success) {
                    // Navigate to OTP screen if login is successful
                    Navigator.pushNamed(context, 'otp');
                  } else {
                    // Show toast for invalid phone number
                    Fluttertoast.showToast(
                      msg: 'Invalid PhoneNumber',
                      backgroundColor: kBlack,
                    );
                  }
                }
              },
              text: 'Continue ',
              color: loginCtrl.phoneCtrl.text.length == 10
                  ? kDarkBlue
                  : const Color.fromARGB(255, 192, 195, 228),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
