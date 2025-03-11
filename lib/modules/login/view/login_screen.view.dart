import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../global/constants/images/images.dart';
import '../../../global/constants/styles/colors.dart';
import '../../../global/constants/styles/text_styles.dart';
import '../../../global/constants/widgets/common_ button.widget.dart';
import '../../../global/constants/widgets/textfield.widget.dart';
import '../../splash/controller/splash_controller.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPhoneValid = false;
  int requiredLength = 10;

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginController, SplashController>(
      builder: (context, loginCtrl, splashCtrl, _) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(MediaQuery.of(context).size.height * 0.1),
                    Center(
                      child: Image.asset(
                        login,
                        width: MediaQuery.of(context).size.width * 0.5,
                        fit: BoxFit.contain,
                      ),
                    ),
                    KStyles().semiBold17(text: 'Login', color: kBlue),
                    Gap(20.h),

                    /// **Phone Number Field**
                    PhoneTextField(
                      controller: loginCtrl.phoneCtrl,
                      onChanged: (phone) {
                        setState(() {
                          isPhoneValid = phone.number.length == requiredLength;
                        });
                      },
                      onCountryChanged: (maxLength) {
                        setState(() {
                          requiredLength = maxLength;
                          isPhoneValid = false;
                        });
                      },
                    ),
                    Gap(7.h),
                    KStyles().med11(
                      text: 'Please enter your whatsapp number to continue.',
                    ),
                    Gap(25.h),

                    Center(
                      child: KStyles().med11(
                          text: 'If you continue, you are accepting',
                          color: kBlack),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            loginCtrl.launchURL(
                                'https://neethusacademy.com/terms-conditions.html');
                          },
                          child: KStyles().med11(
                              text: 'Terms and Conditions ',
                              color: kBlue,
                              textDecoration: TextDecoration.underline),
                        ),
                        KStyles().med11(text: ' and '),
                        InkWell(
                          onTap: () {
                            loginCtrl.launchURL(
                                'https://neethusacademy.com/privacy-policy.html');
                          },
                          child: KStyles().med11(
                              text: ' Privacy Policy',
                              color: kBlue,
                              textDecoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// **Continue Button**
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 30.h, left: 30.w, right: 30.w),
            child: CommonButtonWidget(
              isLoading: loginCtrl.apiLoading,
              icon: true,
              onPressed: () async {
                if (isPhoneValid) {
                  loginCtrl.setLoginVal(0);
                  bool success = await loginCtrl.loginApi();
                  if (success) {
                    Navigator.pushNamed(context, 'otp');
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Invalid Phone Number',
                      backgroundColor: kBlack,
                    );
                  }
                } else {}
              },
              text: 'Continue',
              color: isPhoneValid ? kBlue : kBorderGrey, // Change button color
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
