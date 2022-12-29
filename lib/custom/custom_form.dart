import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class CustomFormField extends StatelessWidget {
  final String? hintText;
  final double? paddingSize;
  final double? borderRadius;
  final TextEditingController? textController;
  final double? hintTextSize;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? iconSize;
  final Color? iconColor;

  const CustomFormField({Key? key,
    this.hintText,
    this.paddingSize,
    this.prefixIcon,
    this.borderRadius,
    this.textController,
    this.hintTextSize,
    this.suffixIcon,
    this.iconSize = 0,
    this.iconColor = const Color(0xFF731942),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.height85,
      child: TextField(
        controller: textController,
        cursorColor: AppColors.redSecondaryColor,
        cursorWidth: AppDimensions.width3,
        style: TextStyle(
          //height: 1,
            fontFamily: "Robotto",
            fontWeight: FontWeight.w500,
            fontSize: AppDimensions.font22,
            color: AppColors.mainColor.withOpacity(0.7)
        ),
        decoration: InputDecoration(

            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontSize: AppDimensions.font22,
              //fontFamily: "Roboto"
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
            prefixIcon: Icon(
              prefixIcon, size: iconSize == 0 ? 20 : iconSize,
              color: iconColor,
            ),
            suffixIcon: suffixIcon!= null ? Icon(
              suffixIcon,
              size: iconSize == 0 ? 20  : iconSize,
              color: iconColor,
            ) : null,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius!)
            )

        ),
      ),
    );
  }
}
