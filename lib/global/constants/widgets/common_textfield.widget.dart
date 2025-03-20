import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/colors.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    this.onTap,
    this.label,
    this.style,
    this.prefix,
    this.suffix,
    this.focusNode,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.labelText,
    this.boxHeight,
    this.showCursor,
    this.suffixIcon,
    this.maxLines = 1,
    this.textInputAction,
    required this.hintText,
    required this.readOnly,
    required this.boxWidth,
    required this.textAlign,
    required this.textColor,
    this.obscureText = false,
    required this.textEditingController,
    this.keyboardType = TextInputType.name,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.textCapitalization = TextCapitalization.none,
    this.onFieldSubmitted,
    this.textInputFormatter,
  });

  int maxLines;
  bool readOnly;
  Widget? label;
  Widget? prefix;
  Widget? suffix;
  int? maxLength;
  TextStyle? style;
  String? labelText;
  bool? obscureText;
  Widget? suffixIcon;
  FocusNode? focusNode;
  final String hintText;
  final double boxWidth;
  final double? boxHeight;
  final Color textColor;
  void Function()? onTap;
  bool? showCursor = true;
  EdgeInsets? scrollPadding;
  Function(String)? onChanged;
  final TextInputType keyboardType;
  TextInputAction? textInputAction;
  TextAlign textAlign = TextAlign.left;
  String? Function(String?)? validator;
  TextCapitalization textCapitalization;
  final TextEditingController textEditingController;
  Function(String)? onFieldSubmitted;
  List<TextInputFormatter>? textInputFormatter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth,
      child: TextFormField(
        autofocus: false,
        onFieldSubmitted: onFieldSubmitted,
        cursorHeight: 20,
        onTap: onTap,
        inputFormatters: textInputFormatter,
        readOnly: readOnly,
        cursorColor: kBlack,
        maxLength: maxLength,
        textAlign: textAlign,
        validator: validator,
        onChanged: onChanged,
        showCursor: showCursor,
        obscureText: obscureText!,
        keyboardType: keyboardType,
        scrollPadding: scrollPadding!,
        textInputAction: textInputAction,
        controller: textEditingController,
        enableInteractiveSelection: true,
        textCapitalization: textCapitalization,
        maxLines: maxLines,
        style: GoogleFonts.manrope(
            fontSize: 14.sp, color: textColor, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: 9.h, horizontal: 12.w), // ✅ Reduced
          prefixIcon: prefix,
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: labelText,
          suffix: suffix,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: kBorderGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: kBorderGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: kBorderGrey),
          ),
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
          isDense: true, // ✅ Important for tight layout
          counterText: '', // ✅ Hide counter if you use maxLength
          errorStyle: GoogleFonts.manrope(
            fontSize: 10.sp,
            color: kRed,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
