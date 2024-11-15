import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:neethusacademy/modules/login/service/login_service.dart';

class LoginController extends ChangeNotifier{
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController pinCtrl = TextEditingController();
  ValueNotifier<Color> buttonColor = ValueNotifier<Color>(const Color.fromARGB(255, 146, 147, 147));
  FocusNode pinFocus = FocusNode();
   int start = 30;
  bool isResendEnabled = false;
  bool hasExpired = false; 
late  Timer timer;

  void startTimer() {
    start = 30;
    hasExpired = false; // Reset expiration flag
    isResendEnabled = false;
    notifyListeners();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start > 0) {
        start--;
      } else {
        hasExpired = true; // Set flag when time expires
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

String dialCode = 'IN';
onPhoneNumberChanges(PhoneNumber number) {
   dialCode = number.isoCode.toString();
    notifyListeners();
  }


  String otpVal = '';
  String phoneNum = '';
   Future<bool>loginApi() async{
    otpVal = '';
    phoneNum = '';
  final response = await LoginService().sendOtp({'phone_number' : phoneCtrl.text});
  if(response.statusCode == 200){
    otpVal = json.decode(response.body)['0']['otp_val'].toString();
    phoneNum = json.decode(response.body)['0']['phone_number'].toString();
    log(otpVal);

    log(phoneNum);
    notifyListeners();
    log('success');
   return true;
  }
  else{
    notifyListeners();
    log('failure');
   return false;
  }
  
  }
}