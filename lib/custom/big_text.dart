

// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

import '../utils/app_dimensions.dart';


class BigText extends StatelessWidget {
  final Color? textColor;
  final String text;
  final String? fontStyle;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  double size;
  TextOverflow textOverflow;

  BigText({Key? key,
    this.textColor = const Color(0xFF332d2b),
    required this.text ,
    this.fontWeight = FontWeight.w400,
    this.textOverflow = TextOverflow.ellipsis,
    this.size = 0,
    this.textAlign,
    this.fontStyle,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor,
        fontWeight: fontWeight,
        fontFamily: fontStyle ?? 'Roboto',
        fontSize: size==0?AppDimensions.font20:size,
      ),

    );
  }
}
