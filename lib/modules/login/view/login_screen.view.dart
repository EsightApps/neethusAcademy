import 'package:NeethusApp/global/constants/widgets/common_textfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        return GestureDetector(
          onTap: () {
            setState(() {
              FocusScope.of(context).unfocus();
            });
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kWhite,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(50.h),
                      Center(
                        child: Image.asset(
                          login,
                          width: MediaQuery.of(context).size.width * 0.5,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Center(
                          child: KStyles()
                              .semiBold20(text: 'Login', color: kBlue)),
                      Gap(20.h),
                      KStyles().med14(
                        text: '  Name',
                      ),
                      Gap(8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: TextFieldWidget(
                          onChanged: (value){
                            setState(() {
                              
                            });
                          },
                            textInputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s]')),
                            ],
                            keyboardType: TextInputType.name,
                            hintText: 'Enter your name',
                            readOnly: false,
                            boxWidth: double.infinity,
                            textAlign: TextAlign.left,
                            textColor: kBlack,
                            textEditingController: loginCtrl.nameCtrl),
                      ),
                      Gap(10.h),
                      KStyles().med14(
                        text: '  Phone Number',
                      ),
                      Gap(8.h),
                      PhoneTextField(
                        controller: loginCtrl.phoneCtrl,
                        onChanged: (phone) {
                          setState(() {
                            isPhoneValid =
                                phone.number.length == requiredLength;

                            if (isPhoneValid) {
                              FocusScope.of(context).unfocus();
                            }
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
                      Center(
                        child: KStyles().med11(
                          textAlign: TextAlign.center,
                          text:
                              'Please enter your whatsapp number to continue.',
                        ),
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
              padding: EdgeInsets.only(bottom: 30.h, left: 20.w, right: 20.w),
              child: CommonButtonWidget(
                isLoading: loginCtrl.apiLoading,
                icon: true,
                onPressed: () async {
                  if (isPhoneValid && loginCtrl.nameCtrl.text.isNotEmpty) {
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
                color: (isPhoneValid && loginCtrl.nameCtrl.text.isNotEmpty) ? kBlue : kBorderGrey,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        );
      },
    );
  }
}
