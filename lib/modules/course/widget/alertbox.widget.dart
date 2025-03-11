import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../global/constants/styles/colors.dart';
import '../../../global/constants/styles/text_styles.dart';
import '../../../global/constants/widgets/common_ button.widget.dart';

class AlertBoxWidget extends StatelessWidget {
  const AlertBoxWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onPressed,
      required this.content});
  final String title;
  final String subtitle;
  final String content;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: kWhite,
        title: KStyles().med17(text: title, color: kBlue),
        content: KStyles().med15(text: content),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonButtonWidget(
                  isLoading: false,
                  icon: false,
                  borderRadius: 20.r,
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  text: 'Cancel',
                  color: kBlue),
              CommonButtonWidget(
                  isLoading: false,
                  icon: false,
                  borderRadius: 20.r,
                  onPressed: onPressed,
                  text: subtitle,
                  color: kBlue)
            ],
          ),
        ]);
  }
}
