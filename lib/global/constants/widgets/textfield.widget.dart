import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:neethusacademy/modules/login/controller/login_controller.dart';
import 'package:provider/provider.dart';
// ignore: must_be_immutable
class PhoneTextField extends StatelessWidget {
  PhoneTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.validator,
    this.autoValidateMode,
  });

  final TextEditingController controller;
  final Function(PhoneNumber number) onChanged;
  String? Function(String?)? validator;
  AutovalidateMode? autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, logCtrl, _) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SizedBox(
            child: InternationalPhoneNumberInput(
              
              maxLength: 10,
              textStyle: GoogleFonts.manrope(
                  color: kGrey, fontWeight: FontWeight.normal, fontSize: 16),
              onInputChanged: (PhoneNumber number) {
                onChanged(number); // Capture the country code change
                log("Dial code: ${number.dialCode}"); // Log dial code changes
              },
              selectorConfig: const SelectorConfig(
                leadingPadding: 10.0,
                trailingSpace: false,
                setSelectorButtonAsPrefixIcon: true,
                selectorType: PhoneInputSelectorType.DIALOG,
              ),
              ignoreBlank: true,
              validator: validator,
              selectorTextStyle: GoogleFonts.manrope(
                  color: kGrey, fontWeight: FontWeight.normal, fontSize: 16),
              initialValue: PhoneNumber(isoCode: logCtrl.dialCode), // Default country code
              textFieldController: controller,
              formatInput: false,
              keyboardType: const TextInputType.numberWithOptions(),
              inputDecoration: InputDecoration(
                isDense: true,
                hintText: "Enter your mobile number", // Include hintText here
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kBorderGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kBorderGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kBorderGrey),
                ),
              ),
              onSaved: (PhoneNumber number) {
                log("Saved PhoneNumber: ${number.toString()}");
              },
            ),
          ),
        );
      },
    );
  }
}
