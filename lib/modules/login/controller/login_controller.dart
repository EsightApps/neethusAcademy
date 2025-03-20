import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../global/constants/styles/colors.dart';
import '../service/login_service.dart';

class LoginController extends ChangeNotifier {
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController pinCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  String countryCode = '91';
  setCountryCode(String code) {
    countryCode = code;
    notifyListeners();
  }

  ValueNotifier<Color> buttonColor =
      ValueNotifier<Color>(const Color.fromARGB(255, 146, 147, 147));
  FocusNode pinFocus = FocusNode();
  int start = 30;
  bool isResendEnabled = false;
  bool hasExpired = false;
  late Timer timer;

  startTimer() {
    start = 30;
    hasExpired = false;
    isResendEnabled = false;
    notifyListeners();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start > 0) {
        start--;
      } else {
        hasExpired = true;
        timer.cancel();
        pinCtrl.text = '';
        isResendEnabled = true;
      }
      notifyListeners();
    });
  }

  resendOtp() {
    loginApi();
    startTimer();
  }

  updatePin(String code) {
    pinCtrl.text = code;
    log(code);
    notifyListeners();
  }

  String otpVal = '';
  String phoneNum = '';
  bool apiLoading = false;
  int val = 0;
  setLoginVal(int value) {
    val = value;
    notifyListeners();
  }

  String userId = '';
  Future<bool> loginApi() async {
    otpVal = '';
    phoneNum = '';
    val == 0 ? (apiLoading = true) : '';
    final response = await LoginService()
        .sendOtp({'name' : nameCtrl.text,
          'phone_number': '$countryCode${phoneCtrl.text}'});
    if (response.statusCode == 200) {
      val == 0 ? (apiLoading = false) : '';
      otpVal = json.decode(response.body)['0']['otp_val'].toString();
      phoneNum = json.decode(response.body)['0']['phone_number'].toString();
      userId = json.decode(response.body)['0']['user_id'].toString();
      log(userId);
      log(otpVal);
      log(phoneNum);
      notifyListeners();
      log('success');
      return true;
    } else {
      val == 0 ? (apiLoading = false) : '';
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          backgroundColor: kBlack,
          textColor: kWhite,
          gravity: ToastGravity.TOP);
      notifyListeners();
      log('failure');
      return false;
    }
  }

  launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      log("Launching URL: $url");
      if (await canLaunchUrl(uri)) {
        log("Launching URL with launchUrl");
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        log("Could not launch URL: $url");
        throw 'Could not launch $url';
      }
    } catch (e) {
      log("Error launching URL: $e");
      Fluttertoast.showToast(
        msg: 'Unable to open the link',
        backgroundColor: kBlack,
      );
    }
  }
}
