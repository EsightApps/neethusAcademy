import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../global/config/databox.dart';
import '../../../global/config/db_key.dart';
import '../../../global/constants/images/images.dart';
import '../../../global/constants/styles/colors.dart';
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
          resizeToAvoidBottomInset: true,
          backgroundColor: kWhite,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(80.h),
                Center(
                  child: Image.asset(
                    login,
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.contain,
                  ),
                ),
                Gap(5.h),
                KStyles().semiBold17(text: 'Enter OTP', color: kBlue),
                Gap(20.h),
                PinWidget(
                  controller: loginCtrl.pinCtrl,
                  focusNode: loginCtrl.pinFocus,
                  onChanged: (value) {
                    loginCtrl.updatePin(value);
                    setState(() {});
                  },
                ),
                Gap(10.h),
                SizedBox(
                  width: double.infinity,
                  child: KStyles().med12(
                      textAlign: TextAlign.center,
                      text: 'A 4 digit code has been sent to your whatsapp'),
                ),
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KStyles().med16(
                      text: '  +91 ${loginCtrl.phoneCtrl.text} ',
                      color: kBorderGrey,
                    ),
                    InkWell(
                      radius: 30.r,
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Icon(Icons.edit_outlined,
                            color: kGrey, size: 17.sp),
                      ),
                    )
                  ],
                ),
                Gap(5.h),
                loginCtrl.isResendEnabled
                    ? TextButton(
                        iconAlignment: IconAlignment.start,
                        onPressed: () {
                          loginCtrl.setLoginVal(1);
                          loginCtrl.resendOtp();
                        },
                        child:
                            KStyles().med16(text: 'Resend OTP', color: kBlue))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          KStyles().med15(text: 'Resend OTP in '),
                          KStyles().med15(
                              text: '${loginCtrl.start} seconds', color: kRed)
                        ],
                      ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 30.h, left: 30.w, right: 30.w),
            child: CommonButtonWidget(
              isLoading: false,
              icon: true,
              onPressed: () {
                if (loginCtrl.pinCtrl.text == loginCtrl.otpVal &&
                    !loginCtrl.hasExpired) {
                  userSavedBox.put(DbKey().userSaved, loginCtrl.phoneNum);
                  loginCtrl.timer.cancel();

                  Navigator.pushNamedAndRemoveUntil(
                      context, 'course', (routes) => false);
                } else {
                  Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_SHORT,
                      msg: 'Incorrect OTP',
                      backgroundColor: kBlack,
                      gravity: ToastGravity.TOP);
                }
              },
              text: 'Continue',
              color: loginCtrl.pinCtrl.text.length == 4 ? kBlue : kBorderGrey,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
