
import 'package:flutter/cupertino.dart';

import '../utils/app_dimensions.dart';

class SmallText extends StatelessWidget {
  final String text;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextAlign?  textAlign;

  const SmallText({Key? key,
    required this.text,
    this.textSize = 0,
    this.fontWeight = FontWeight.w400,
    this.textColor = const Color(0xFF929292),
    this.textAlign
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: textSize==0?AppDimensions.font15:textSize,
          fontFamily: "Roboto"
      ),
    );
  }
}