import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:neethusacademy/modules/login/service/login_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginController extends ChangeNotifier{
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController pinCtrl = TextEditingController();
  ValueNotifier<Color> buttonColor = ValueNotifier<Color>(const Color.fromARGB(255, 146, 147, 147));
  FocusNode pinFocus = FocusNode();
  int start = 30;
  bool isResendEnabled = false;
  bool hasExpired = false; 
  late  Timer timer;

   startTimer() {
    start = 30;
    hasExpired = false; 
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

 updatePin(String code) {
  pinCtrl.text = code;
  log(code);
  notifyListeners();
}

  String otpVal = '';
  String phoneNum = '';
  bool apiLoading = false;
  int val =0;
  setLoginVal(int value){
  val = value;
  notifyListeners();
  }
   Future<bool>loginApi() async{
    otpVal = '';
    phoneNum = '';
  val == 0 ? (apiLoading = true) : '';
  final response = await LoginService().sendOtp({'phone_number' : phoneCtrl.text});
  if(response.statusCode == 200){
    val == 0 ? (apiLoading = false) : '';
    otpVal = json.decode(response.body)['0']['otp_val'].toString();
    phoneNum = json.decode(response.body)['0']['phone_number'].toString();
    log(otpVal);

    log(phoneNum);
    notifyListeners();
    log('success');
   return true;
  }
  else{
    val == 0 ? (apiLoading = false) : '';
    Fluttertoast.showToast(msg: 'Something went wrong',backgroundColor: kBlack,textColor: kWhite,gravity: ToastGravity.TOP);
    notifyListeners();
    log('failure');
   return false;
  }
  
  }
  launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      // Show an error message if the URL can't be launched
      throw 'Could not launch $url';
    }
  }
}