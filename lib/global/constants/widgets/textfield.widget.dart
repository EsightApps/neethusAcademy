import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:provider/provider.dart';
import '../../../modules/login/controller/login_controller.dart';
import '../styles/colors.dart';

// ignore: must_be_immutable
class PhoneTextField extends StatefulWidget {
  PhoneTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onCountryChanged,
    this.validator,
    this.autoValidateMode,
  });

  final TextEditingController controller;
  final Function(PhoneNumber number) onChanged;
  final Function(int maxLength) onCountryChanged;
  String? Function(String?)? validator;
  AutovalidateMode? autoValidateMode;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  int maxLength = 10; // Default max length

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, logCtrl, _) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SizedBox(
            child: IntlPhoneField(
              disableLengthCheck: true,
      
              pickerDialogStyle: PickerDialogStyle(
                searchFieldPadding: EdgeInsets.all(5),
                listTileDivider: Divider(
                  thickness: 0.5,
                  color: kBorderGrey,
                ),
                backgroundColor: kWhite,
                countryCodeStyle: GoogleFonts.manrope(
                  color: kBlack,
                  fontWeight: FontWeight.normal,
                  fontSize: 15.sp,
                ),
                countryNameStyle: GoogleFonts.manrope(
                  color: kBlack,
                  fontWeight: FontWeight.normal,
                  fontSize: 15.sp,
                ),
              ),
              cursorHeight: 15.h,
              cursorColor: kBlack,

              controller: widget.controller,
              autovalidateMode: widget.autoValidateMode,
              initialCountryCode: logCtrl.dialCode,
              onChanged: (PhoneNumber number) {
                widget.onChanged(number);
              },
              onCountryChanged: (country) {
                var countryData = countries.firstWhere(
                  (element) => element.code == country.code,
                  orElse: () => Country(
                      code: '',
                      dialCode: '',
                      name: '',
                      maxLength: 10,
                      flag: '',
                      nameTranslations: {},
                      minLength: 10),
                );

                setState(() {
                  maxLength = countryData.maxLength;
                  widget.controller.clear();
                });

                widget.onCountryChanged(maxLength);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxLength)
              ], // Enforce max length
              decoration: InputDecoration(
                hintStyle: GoogleFonts.manrope(
                  color: kBorderGrey,
                  fontWeight: FontWeight.normal,
                  fontSize: 13.sp,
                ),
                labelStyle: GoogleFonts.manrope(
                  color: kBlack,
                  fontWeight: FontWeight.normal,
                  fontSize: 15.sp,
                ),
                isDense: true,
                hintText: "Enter your mobile number",
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
            ),
          ),
        );
      },
    );
  }
}
