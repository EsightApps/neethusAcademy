import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../styles/colors.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PinWidget extends StatefulWidget {
  const PinWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String value) onChanged;

  @override
  State<PinWidget> createState() => _PinWidgetState();
}

class _PinWidgetState extends State<PinWidget> with CodeAutoFill {
  @override
  void initState() {
    super.initState();
    listenForCode(); // Start listening for SMS code when widget is initialized
  }

  @override
  void codeUpdated() {
    // This method is called automatically when the OTP is received
    setState(() {
      widget.controller.text = code ?? '';  // Update controller with the received OTP
    });
    widget.onChanged(code.toString());  // Notify parent widget of the code change
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener(); // Stop listening for OTP
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      autofocus: true,
      showCursor: true,
      controller: widget.controller,
      focusNode: widget.focusNode,
      defaultPinTheme: PinTheme(
        width: 50,
        height: 50,
        textStyle: GoogleFonts.manrope(
          fontSize: 18,
          color: kBlack,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: kBorderGrey),
          color: kWhite,
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 50,
        height: 50,
        textStyle: GoogleFonts.manrope(
          fontSize: 18,
          color: kBlack,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: kGreen),
          color: kWhite,
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      separatorBuilder: (index) => SizedBox(width: 20),
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onCompleted: (pin) {
        debugPrint('onCompleted: $pin');
      },
      onChanged: widget.onChanged,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22,
            height: 1,
            color: kBlack,
          ),
        ],
      ),
    );
  }
}