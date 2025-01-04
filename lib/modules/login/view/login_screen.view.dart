import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
        return Scaffold(
          resizeToAvoidBottomInset: false, // Adjust layout for keyboard
          backgroundColor: kWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(MediaQuery.of(context).size.height * 0.1), // Dynamic gap
                    Center(
                      child: Image.asset(
                        login,
                        width: MediaQuery.of(context).size.width * 0.5,
                        fit: BoxFit.contain,
                      ),
                    ),
                    KStyles().semiBold17(text: 'Login', color: kBlue),
                    Gap(20.h),
                    PhoneTextField(
                      controller: loginCtrl.phoneCtrl,
                      onChanged: (PhoneNumber number) {
                        // Update phone number and UI state
                        loginCtrl.onPhoneNumberChanges(number);
                        setState(() {});
                      },
                    ),
                    Gap(7.h),
                    KStyles().med12(
                      text: 'Please enter your mobile number to continue.',
                    ),
                    Gap(30.h),
                   Center(child: KStyles().med11(text: 'If you continue, you are accepting',color: kBlack)),
              Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 InkWell(
                onTap: (){
                          loginCtrl.launchURL('https://esightsolutions.in/neethusapp/demo2/terms')   ;        
                  }, child:  KStyles().med11(text: 'Terms and Conditions ',color: kBlue,textDecoration: TextDecoration.underline)),
                
                  KStyles().med11(text: ' and '),
                   InkWell(onTap: (){
                    loginCtrl.launchURL('https://esightsolutions.in/neethusapp/demo2/privacy');
                                 
                                     }, child:  KStyles().med11(text: ' Privacy Policy',color: kBlue,textDecoration: TextDecoration.underline))
                ],
              ),
                    Gap(50.h),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 30.h, left: 30.w, right: 30.w),
            child: CommonButtonWidget(
              isLoading: loginCtrl.apiLoading,
              icon: true,
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
                  ? kBlue
                  : kBorderGrey,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
