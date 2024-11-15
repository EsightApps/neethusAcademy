
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:neethusacademy/global/config/databox.dart';
import 'package:neethusacademy/global/config/db_key.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../../global/constants/images/images.dart';
import '../../../global/constants/styles/text_styles.dart';
import '../../../global/constants/widgets/common_ button.widget.dart';
import '../../../global/constants/widgets/pinput_widget.dart';
import '../controller/login_controller.dart';


class OtpScreenView extends StatefulWidget {
  const OtpScreenView({super.key});

  @override
  State<OtpScreenView> createState() => _OtpScreenViewState();
}

class _OtpScreenViewState extends State<OtpScreenView> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var logCtrl = Provider.of<LoginController>(context, listen: false);
      logCtrl.pinCtrl.clear();
      logCtrl.startTimer();
    });

    
  }

  

  

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, loginCtrl, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kWhite,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(80.h),
                Center(child: Lottie.asset(login, animate: true, width: 200.w, height: 200.h)),
                KStyles().light18(text: 'Enter OTP'),
                Gap(10.h),
                PinWidget(
                  controller: loginCtrl.pinCtrl,
                  focusNode: loginCtrl.pinFocus,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                Gap(10.h),
                KStyles().light13(text: 'A 4 digit code has been sent to your Mobile Number'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KStyles().light16(
                      text: '  +91 ${loginCtrl.phoneCtrl.text}',
                      color: kBlack.withOpacity(0.5),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      icon: Icon(Icons.edit, color: kBlack.withOpacity(0.5), size: 17.sp),
                    )
                  ],
                ),
                Gap(10.h),
               loginCtrl.isResendEnabled
                    ? TextButton(
                        onPressed: () {
                         loginCtrl.resendOtp();
                        },
                        child: KStyles().med14(text: 'Resend OTP',color: kBlue))
                    : Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [  KStyles().light14(text: 'Resend OTP in '),KStyles().light14(text:'${loginCtrl.start} seconds',color: kRed)],)
                   ,
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 30.h,left: 10.w,right: 10.w),
            child: CommonButtonWidget(
              onPressed: () {
                if (loginCtrl.pinCtrl.text == loginCtrl.otpVal && !loginCtrl.hasExpired) {
                  userSavedBox.put(DbKey().userSaved, loginCtrl.phoneNum);
                  loginCtrl.timer.cancel();

               Navigator.pushNamedAndRemoveUntil(context, 'course', (routes) => false);
                } else {
                  Fluttertoast.showToast(msg: 'Incorrect OTP', backgroundColor: kBlack);
                }
              },
              text: 'Continue',
              color: loginCtrl.pinCtrl.text.length == 4 ? kBlue : const Color.fromARGB(255, 146, 147, 147),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
