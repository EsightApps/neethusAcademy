import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../styles/colors.dart';

class UIConstants {
  //*---------------------------------------------------------------- ( Loader )
  Widget loader({double size = 60, Color color = kWhite}) {
    return LoadingAnimationWidget.newtonCradle(
      size: size,
      color: color,
    );
  }
  //*---------------------------------------------------------------- ( Loader )

  //*---------------------------------------------------------------- ( Button Loader )
  Widget buttonlLoader({double size = 60, Color color = kWhite}) {
    return LoadingAnimationWidget.threeArchedCircle(
      size: size,
      color: color,
    );
  }
}