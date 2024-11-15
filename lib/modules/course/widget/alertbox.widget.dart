import 'package:flutter/material.dart';
import 'package:neethusacademy/global/constants/widgets/common_%20button.widget.dart';

import '../../../global/constants/styles/colors.dart';
import '../../../global/constants/styles/text_styles.dart';

class AlertBoxWidget extends StatelessWidget {
  const AlertBoxWidget({super.key,required this.title,required this.subtitle,required this.onPressed,required this.content});
final String title;
final String subtitle;
final String content;
final Function()onPressed;
  @override
  Widget build(BuildContext context) {
  return AlertDialog(backgroundColor: kWhite,
   title: KStyles().med17(text: title,color: kBlue) ,
    content: KStyles().med15(text: content),
    actions: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonButtonWidget(onPressed: (){
            Navigator.maybePop(context);
          }, text: 'Cancel', color: kBlue),
           CommonButtonWidget(onPressed: onPressed, text: subtitle, color:  kBlue)
        ],
      ),
     
    ]);
  }
}