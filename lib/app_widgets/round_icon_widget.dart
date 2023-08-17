import 'package:flutter/cupertino.dart';

import '../utils/color_constant.dart';

class RoundIconWidget extends StatelessWidget {
  String img;
  Color? bgColor;
  Color? iconColor;
  RoundIconWidget({super.key, required this.img, this.bgColor, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        padding: EdgeInsets.all(9),
        decoration:
        BoxDecoration(color: bgColor ?? ColorConstant.lightGrey, shape: BoxShape.circle),
        child: Center(
          child: Image.asset(
            img,
            color: iconColor ?? ColorConstant.darkGrey,
          ),
        ),
      );
  }
}
